import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alpaca_markets/alpaca_markets.dart';

void main() {
  String getApcaApiKeyId() {
    // Add your paper API key ID
    return "PKPRO7JXVLKFDZG0Q864";
  }

  String getApcaApiSecretKey() {
    // Add your paper API secret key
    return "EyngG12OXYyDLxDmhhxrH2kDVgvFpTITjjgY5ELB";
  }

  test('Evaluate account', () async {
    AlpacaMarkets am = AlpacaMarkets(
        paperApacApiKeyId: getApcaApiKeyId(),
        paperApcaApiSecretKey: getApcaApiSecretKey());
    Account? account = await am.getAccount();
    expect(account, isNot(null));
    if (account != null) {
      expect(account.toMap(), Account.fromMap(account.toMap())?.toMap());
    }
  });

  test('Evaluate assets', () async {
    AlpacaMarkets am = AlpacaMarkets(
        paperApacApiKeyId: getApcaApiKeyId(),
        paperApcaApiSecretKey: getApcaApiSecretKey());
    // Test without any parameters
    List<Asset>? assets = await am.getAssets();
    expect(assets, isNot(null));
    if (assets != null) {
      expect(assets.isNotEmpty, true);
    }
    // Test with parameters
    assets = await am.getAssets(status: "active", exchange: "NYSE");
    expect(assets, isNot(null));
    if (assets != null) {
      for (Asset asset in assets) {
        expect(asset.status, "active");
        expect(asset.exchange, "NYSE");
      }
    }

    Asset? asset = await am.getAsset("GRMN");
    expect(asset, isNot(null));
    if (asset != null) {
      expect(asset.name, "Garmin Ltd");
    }
  });

  test('Evaluate watchlists', () async {
    AlpacaMarkets am = AlpacaMarkets(
        paperApacApiKeyId: getApcaApiKeyId(),
        paperApcaApiSecretKey: getApcaApiSecretKey());
    // Perform a delete prior to testing.
    await am.deleteAllWatchlists();
    // Retrieve an empty list
    List<Watchlist>? watchlists = await am.getWatchlists();
    expect(watchlists, isNot(null));
    expect(watchlists?.length, 0);
    // Create a watchlist
    List<String> symbols = ["GRMN", "AAPL", "TSLA"];
    Watchlist? watchlist =
        await am.createWatchlist("FlutterTester", symbols: symbols);
    expect(watchlist, isNot(null));
    if (watchlist == null) {
      return;
    }
    // Retrieve the watchlist
    watchlists = await am.getWatchlists(withAssets: true);
    expect(watchlists, isNot(null));
    if (watchlists == null) {
      return;
    }
    expect(watchlists.length, 1);
    expect(watchlist.name, watchlists[0].name);
    expect(watchlists[0].assets.length, symbols.length);
    for (Asset asset in watchlists[0].assets) {
      expect(symbols.contains(asset.symbol), true);
    }
    // Delete one of the symbols
    await am.deleteWatchlistSymbol(watchlist.id, "TSLA");
    watchlist = await am.getWatchlist(watchlist.id);
    expect(watchlist, isNot(null));
    expect(watchlist?.assets.length, 2);
    // Update the list with a new name and the symbols list
    await am.updateWatchlist(watchlist!.id,
        name: "FlutterTesterPlus", symbols: ["GOOGL"]);
    watchlist = await am.getWatchlist(watchlist.id);
    expect(watchlist, isNot(null));
    expect(watchlist?.name, "FlutterTesterPlus");
    expect(watchlist?.assets.length, 1);
    // Add an asset to the watchlist and confirm the symbols
    await am.addWatchlistSymbol(watchlist!.id, "GRMN");
    watchlist = await am.getWatchlist(watchlist.id);
    expect(watchlist, isNot(null));
    expect(watchlist?.assets.length, 2);
    expect(
        watchlist?.assets[0].symbol == "GRMN" ||
            watchlist?.assets[1].symbol == "GRMN",
        true);
  });

  test('Evaluate calendar', () async {
    AlpacaMarkets am = AlpacaMarkets(
        paperApacApiKeyId: getApcaApiKeyId(),
        paperApcaApiSecretKey: getApcaApiSecretKey());
    DateTime dateTime = DateTime(2022, 9, 16);
    // Perform request for a single date
    Calendar? calendar = await am.getCalendarDate(dateTime);
    expect(calendar, isNot(null));
    if (calendar != null) {
      expect(calendar.date.year, dateTime.year);
      expect(calendar.date.month, dateTime.month);
      expect(calendar.date.day, dateTime.day);
      expect(calendar.open, const TimeOfDay(hour: 9, minute: 30));
      expect(calendar.close, const TimeOfDay(hour: 16, minute: 0));
    }
    // Perform a request for a date range
    List<Calendar>? calendars = await am.getCalendarDates(
        start: dateTime.subtract(const Duration(days: 6)), end: dateTime);
    expect(calendars?.length, 5);
  });

  test('Evaluate clock', () async {
    AlpacaMarkets am = AlpacaMarkets(
        paperApacApiKeyId: getApcaApiKeyId(),
        paperApcaApiSecretKey: getApcaApiSecretKey());
    expect(await am.getMarketClock(), isNot(null));
  });

  test('Evaluate account configs', () async {
    AlpacaMarkets am = AlpacaMarkets(
        paperApacApiKeyId: getApcaApiKeyId(),
        paperApcaApiSecretKey: getApcaApiSecretKey());
    AccountConfigs? configs = await am.getAccountConfigs();
    expect(configs, isNot(null));
    await am.updateAccountConfigs(tradeConfirmEmail: "none");
    configs = await am.getAccountConfigs();
    if (configs != null) {
      expect(configs.tradeConfirmEmail, "none");
    }
    await am.updateAccountConfigs(tradeConfirmEmail: "all");
    configs = await am.getAccountConfigs();
    if (configs != null) {
      expect(configs.tradeConfirmEmail, "all");
    }
  });
}
