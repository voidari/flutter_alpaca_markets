// Copyright (C) 2022 by Voidari LLC or its subsidiaries.
library alpaca_markets;

/// Used for all watchlist related requests and parsing.

import 'dart:convert';
import 'dart:io';

import 'package:alpaca_markets/src/context.dart';
import 'package:alpaca_markets/src/models/watchlist.dart';
import 'package:alpaca_markets/src/request_builder.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

/// Returns the list of watchlists associated with the API key.
Future<Tuple2<int, List<Watchlist>?>> getWatchlists(
    Context context, bool withAssets) async {
  http.Response response = await RequestBuilder.get(context, "v2/watchlists");
  if (HttpStatus.ok != response.statusCode) {
    return Tuple2(response.statusCode, null);
  }
  dynamic json = jsonDecode(response.body);
  List<Watchlist> watchlists = <Watchlist>[];
  for (dynamic jsonWatchlist in json) {
    Watchlist? watchlist = Watchlist.fromMap(jsonWatchlist);
    if (watchlist == null) {
      continue;
    }
    // If assets need to be included, make an individual request
    if (withAssets) {
      Tuple2<int, Watchlist?> watchlistWithAssets =
          await getWatchlist(context, watchlist.id);
      if (watchlistWithAssets.item2 != null) {
        watchlist = watchlistWithAssets.item2;
      }
    }
    watchlists.add(watchlist!);
  }
  return Tuple2(response.statusCode, watchlists);
}

/// Returns a watchlist identified by the [watchlistId].
Future<Tuple2<int, Watchlist?>> getWatchlist(
    Context context, String watchlistId) async {
  http.Response response =
      await RequestBuilder.get(context, "v2/watchlists/$watchlistId");
  if (HttpStatus.ok != response.statusCode) {
    return Tuple2(response.statusCode, null);
  }
  dynamic json = jsonDecode(response.body);
  return Tuple2(response.statusCode, Watchlist.fromMap(json));
}

/// Create a new watchlist with the provided [name] and optionally with
/// an initial set of assets using the [symbols] list.
/// Returns the created watchlist.
Future<Tuple2<int, Watchlist?>> createWatchlist(Context context, String name,
    {List<String>? symbols}) async {
  if (64 < name.length) {
    return const Tuple2(600, null);
  }
  Map<String, dynamic> body = {"name": name};
  if (symbols != null) {
    body.putIfAbsent("symbols", () => symbols);
  }
  http.Response response = await RequestBuilder.post(context, "v2/watchlists",
      body: jsonEncode(body));
  if (HttpStatus.ok != response.statusCode) {
    return Tuple2(response.statusCode, null);
  }
  dynamic json = jsonDecode(response.body);
  return Tuple2(response.statusCode, Watchlist.fromMap(json));
}

/// Update the name with [name] and/or content of watchlist with new [symbols]
/// of the watchlist specified by the [watchlistId]. Providing [symbols] will
/// replace ALL existing symbols, so it should be the complete list of symbols
/// you want.
/// Returns the edited watchlist.
Future<Tuple2<int, Watchlist?>> updateWatchlist(
    Context context, String watchlistId,
    {String? name, List<String>? symbols}) async {
  if (name == null && symbols == null) {
    return const Tuple2(600, null);
  }
  Map<String, dynamic> body = {};
  if (name != null) {
    body.putIfAbsent("name", () => name);
  }
  if (symbols != null) {
    body.putIfAbsent("symbols", () => symbols);
  }
  http.Response response = await RequestBuilder.put(
      context, "v2/watchlists/$watchlistId",
      body: jsonEncode(body));
  if (HttpStatus.ok != response.statusCode) {
    return Tuple2(response.statusCode, null);
  }
  dynamic json = jsonDecode(response.body);
  return Tuple2(response.statusCode, Watchlist.fromMap(json));
}

/// Adds the [symbol] asset to the watchlist matching the [watchlistId].
/// Returns the watchlist with the added asset.
Future<Tuple2<int, Watchlist?>> addWatchlistSymbol(
    Context context, String watchlistId, String symbol) async {
  Map<String, dynamic> body = {};
  body.putIfAbsent("symbol", () => symbol);
  http.Response response = await RequestBuilder.post(
      context, "v2/watchlists/$watchlistId",
      body: jsonEncode(body));
  if (HttpStatus.ok != response.statusCode) {
    return Tuple2(response.statusCode, null);
  }
  dynamic json = jsonDecode(response.body);
  return Tuple2(response.statusCode, Watchlist.fromMap(json));
}

/// Perform a delete of all watchlists.
Future<void> deleteAllWatchlists(Context context) async {
  Tuple2<int, List<Watchlist>?> watchlists =
      await getWatchlists(context, false);
  if (watchlists.item2 == null) {
    return;
  }
  for (Watchlist watchlist in watchlists.item2!) {
    await deleteWatchlist(context, watchlist.id);
  }
}

/// Performs a delete of a specific watchlist matching
/// the [watchlistId] provided. To remove a specific asset, include
/// its [symbol] as a parameter.
Future<void> deleteWatchlist(Context context, String watchlistId,
    {String? symbol}) async {
  String endpoint = "v2/watchlists/$watchlistId";
  if (symbol != null) {
    endpoint += "/$symbol";
  }
  await RequestBuilder.delete(context, endpoint);
}

/// Performs a delete of a specific watchlist's symbol matching
/// the [watchlistId] and [symbol] provided.
Future<void> deleteWatchlistSymbol(
    Context context, String watchlistId, String symbol) async {
  await deleteWatchlist(context, watchlistId, symbol: symbol);
}
