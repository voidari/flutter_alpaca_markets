// Copyright (C) 2022 by Voidari LLC or its subsidiaries.

import 'dart:io';

import 'package:alpaca_markets/src/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alpaca_markets/alpaca_markets.dart' as alpaca;
import 'package:tuple/tuple.dart';

alpaca.Context getContext() {
  // Add your paper API key ID
  String apcaApiKeyId = "PKPRO7JXVLKFDZG0Q864";
  String apcaApiSecretKey = "EyngG12OXYyDLxDmhhxrH2kDVgvFpTITjjgY5ELB";
  return alpaca.createPaperContext(apcaApiKeyId, apcaApiSecretKey);
}

void main() {
  Settings.debugPrint = true;

  alpaca.Context context = getContext();

  test('Evaluate account', () async {
    Tuple2<int, alpaca.Account?> account = await alpaca.getAccount(context);
    expect(account.item1, HttpStatus.ok);
    expect(account.item2, isNot(null));
    if (account.item2 != null) {
      expect(account.item2!.toMap(),
          alpaca.Account.fromMap(account.item2!.toMap())?.toMap());
    }
  });

  test('Evaluate assets', () async {
    // Test without any parameters
    Tuple2<int, List<alpaca.Asset>?> assets = await alpaca.getAssets(context);
    expect(assets.item1, HttpStatus.ok);
    expect(assets.item2, isNot(null));
    if (assets.item2 != null) {
      expect(assets.item2!.isNotEmpty, true);
    }
    // Test with parameters
    assets =
        await alpaca.getAssets(context, status: "active", exchange: "NYSE");
    expect(assets.item1, HttpStatus.ok);
    expect(assets.item2, isNot(null));
    if (assets.item2 != null) {
      for (alpaca.Asset asset in assets.item2!) {
        expect(asset.status, "active");
        expect(asset.exchange, "NYSE");
      }
    }

    Tuple2<int, alpaca.Asset?> asset = await alpaca.getAsset(context, "GRMN");
    expect(assets.item1, HttpStatus.ok);
    expect(asset.item2, isNot(null));
    if (asset.item2 != null) {
      expect(asset.item2!.name, "Garmin Ltd");
    }
  });

  test('Evaluate watchlists', () async {
    // Perform a delete prior to testing.
    await alpaca.deleteAllWatchlists(context);
    // Retrieve an empty list
    Tuple2<int, List<alpaca.Watchlist>?> watchlists =
        await alpaca.getWatchlists(context, false);
    expect(watchlists.item1, HttpStatus.ok);
    expect(watchlists.item2, isNot(null));
    expect(watchlists.item2?.length, 0);
    // Create a watchlist
    List<String> symbols = ["GRMN", "AAPL", "TSLA"];
    Tuple2<int, alpaca.Watchlist?> watchlist = await alpaca
        .createWatchlist(context, "FlutterTester", symbols: symbols);
    expect(watchlist.item1, HttpStatus.ok);
    expect(watchlist.item2, isNot(null));
    if (watchlist.item2 == null) {
      return;
    }
    // Retrieve the watchlist
    watchlists = await alpaca.getWatchlists(context, true);
    expect(watchlists.item1, HttpStatus.ok);
    expect(watchlists.item2, isNot(null));
    if (watchlists.item2 == null) {
      return;
    }
    expect(watchlists.item2!.length, 1);
    expect(watchlist.item2!.name, watchlists.item2![0].name);
    expect(watchlists.item2![0].assets.length, symbols.length);
    for (alpaca.Asset asset in watchlists.item2![0].assets) {
      expect(symbols.contains(asset.symbol), true);
    }
    // Delete one of the symbols
    await alpaca.deleteWatchlistSymbol(context, watchlist.item2!.id, "TSLA");
    watchlist = await alpaca.getWatchlist(context, watchlist.item2!.id);
    expect(watchlist.item1, HttpStatus.ok);
    expect(watchlist.item2, isNot(null));
    expect(watchlist.item2?.assets.length, 2);
    // Update the list with a new name and the symbols list
    await alpaca.updateWatchlist(context, watchlist.item2!.id,
        name: "FlutterTesterPlus", symbols: ["GOOGL"]);
    watchlist = await alpaca.getWatchlist(context, watchlist.item2!.id);
    expect(watchlist.item1, HttpStatus.ok);
    expect(watchlist.item2, isNot(null));
    expect(watchlist.item2?.name, "FlutterTesterPlus");
    expect(watchlist.item2?.assets.length, 1);
    // Add an asset to the watchlist and confirm the symbols
    await alpaca.addWatchlistSymbol(context, watchlist.item2!.id, "GRMN");
    watchlist = await alpaca.getWatchlist(context, watchlist.item2!.id);
    expect(watchlist.item1, HttpStatus.ok);
    expect(watchlist.item2, isNot(null));
    expect(watchlist.item2!.assets.length, 2);
    expect(
        watchlist.item2?.assets[0].symbol == "GRMN" ||
            watchlist.item2?.assets[1].symbol == "GRMN",
        true);
  });

  test('Evaluate calendar', () async {
    DateTime dateTime = DateTime(2022, 9, 16);
    // Perform request for a single date
    Tuple2<int, alpaca.Calendar?> calendar =
        await alpaca.getCalendarDate(context, dateTime);
    expect(calendar.item1, HttpStatus.ok);
    expect(calendar.item2, isNot(null));
    if (calendar.item2 != null) {
      expect(calendar.item2!.date.year, dateTime.year);
      expect(calendar.item2!.date.month, dateTime.month);
      expect(calendar.item2!.date.day, dateTime.day);
      expect(calendar.item2!.open, const TimeOfDay(hour: 9, minute: 30));
      expect(calendar.item2!.close, const TimeOfDay(hour: 16, minute: 0));
    }
    // Perform a request for a date range
    Tuple2<int, List<alpaca.Calendar>?> calendars =
        await alpaca.getCalendarDates(context,
            start: dateTime.subtract(const Duration(days: 6)), end: dateTime);
    expect(calendars.item2?.length, 5);
  });

  test('Evaluate clock', () async {
    expect((await alpaca.getMarketClock(context)).item2, isNot(null));
  });

  test('Evaluate account configs', () async {
    Tuple2<int, alpaca.AccountConfigs?> configs =
        await alpaca.getAccountConfigs(context);
    expect(configs.item1, HttpStatus.ok);
    expect(configs, isNot(null));
    await alpaca.updateAccountConfigs(context, tradeConfirmEmail: "none");
    configs = await alpaca.getAccountConfigs(context);
    if (configs.item2 != null) {
      expect(configs.item2!.tradeConfirmEmail, "none");
    }
    await alpaca.updateAccountConfigs(context, tradeConfirmEmail: "all");
    configs = await alpaca.getAccountConfigs(context);
    if (configs.item2 != null) {
      expect(configs.item2!.tradeConfirmEmail, "all");
    }
  });

  test('Evaluate portfolio history', () async {
    Tuple2<int, alpaca.PortfolioHistory?> ph =
        await alpaca.getPortfolioHistory(context);
    expect(ph.item1, HttpStatus.ok);
    expect(ph.item2, isNot(null));
  });

  test('Evaluate announcements', () async {
    Tuple2<int, List<alpaca.Announcement>?> announcements =
        await alpaca.getCorporateActionsAnnouncements(context, "Dividend",
            DateTime.now().subtract(const Duration(days: 75)), DateTime.now());
    expect(announcements.item1, HttpStatus.ok);
    expect(announcements.item2, isNot(null));
    expect(announcements.item2?.isNotEmpty, true);
    Tuple2<int, alpaca.Announcement?> announcement = await alpaca
        .getCorporateActionsAnnouncement(context, announcements.item2![0].id);
    expect(announcement.item1, HttpStatus.ok);
    expect(announcement.item2, isNot(null));
    expect(announcement.item2?.id, announcements.item2![0].id);
  });
}
