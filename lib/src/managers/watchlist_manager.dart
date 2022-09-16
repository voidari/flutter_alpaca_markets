library alpaca_markets;

import 'dart:convert';
import 'dart:io';

import 'package:alpaca_markets/src/models/watchlist.dart';
import 'package:alpaca_markets/src/request_builder.dart';
import 'package:http/http.dart' as http;

/// The class used for all watchlist related requests and parsing.
class WatchlistManager {
  /// Returns the list of watchlists associated with the API key.
  static Future<List<Watchlist>?> getWatchlists(
      RequestBuilder requestBuilder, bool withAssets) async {
    http.Response response = await requestBuilder.get("v2/watchlists");
    if (HttpStatus.ok != response.statusCode) {
      return null;
    }
    dynamic json = jsonDecode(response.body);
    List<Watchlist> watchlists = <Watchlist>[];
    for (dynamic jsonWatchlist in json) {
      Watchlist? watchlist = Watchlist.fromJson(jsonWatchlist);
      if (watchlist == null) {
        continue;
      }
      // If assets need to be included, make an individual request
      if (withAssets) {
        Watchlist? watchlistWithAssets =
            await getWatchlist(requestBuilder, watchlist.id);
        if (watchlistWithAssets != null) {
          watchlist = watchlistWithAssets;
        }
      }
      watchlists.add(watchlist);
    }
    return watchlists;
  }

  /// Returns a watchlist identified by the [watchlistId].
  static Future<Watchlist?> getWatchlist(
      RequestBuilder requestBuilder, String watchlistId) async {
    http.Response response =
        await requestBuilder.get("v2/watchlists/$watchlistId");
    if (HttpStatus.ok != response.statusCode) {
      return null;
    }
    dynamic json = jsonDecode(response.body);
    return Watchlist.fromJson(json);
  }

  /// Create a new watchlist with the provided [name] and optionally with
  /// an initial set of assets using the [symbols] list.
  /// Returns the created watchlist.
  static Future<Watchlist?> createWatchlist(
      RequestBuilder requestBuilder, String name,
      {List<String>? symbols}) async {
    if (64 < name.length) {
      return null;
    }
    Map<String, dynamic> body = {"name": name};
    if (symbols != null) {
      body.putIfAbsent("symbols", () => symbols);
    }
    http.Response response =
        await requestBuilder.post("v2/watchlists", body: jsonEncode(body));
    if (HttpStatus.ok != response.statusCode) {
      return null;
    }
    dynamic json = jsonDecode(response.body);
    return Watchlist.fromJson(json);
  }

  /// Update the name with [name] and/or content of watchlist with new [symbols]
  /// of the watchlist specified by the [watchlistId]. Providing [symbols] will
  /// replace ALL existing symbols, so it should be the complete list of symbols
  /// you want.
  /// Returns the edited watchlist.
  static Future<Watchlist?> updateWatchlist(
      RequestBuilder requestBuilder, String watchlistId,
      {String? name, List<String>? symbols}) async {
    if (name == null && symbols == null) {
      return null;
    }
    Map<String, dynamic> body = {};
    if (name != null) {
      body.putIfAbsent("name", () => name);
    }
    if (symbols != null) {
      body.putIfAbsent("symbols", () => symbols);
    }
    http.Response response = await requestBuilder
        .put("v2/watchlists/$watchlistId", body: jsonEncode(body));
    if (HttpStatus.ok != response.statusCode) {
      return null;
    }
    dynamic json = jsonDecode(response.body);
    return Watchlist.fromJson(json);
  }

  /// Adds the [symbol] asset to the watchlist matching the [watchlistId].
  /// Returns the watchlist with the added asset.
  static Future<Watchlist?> addWatchlistSymbol(
      RequestBuilder requestBuilder, String watchlistId, String symbol) async {
    Map<String, dynamic> body = {};
    body.putIfAbsent("symbol", () => symbol);
    http.Response response = await requestBuilder
        .post("v2/watchlists/$watchlistId", body: jsonEncode(body));
    if (HttpStatus.ok != response.statusCode) {
      return null;
    }
    dynamic json = jsonDecode(response.body);
    return Watchlist.fromJson(json);
  }

  /// Perform a delete of all watchlists.
  static Future<void> deleteAllWatchlists(RequestBuilder requestBuilder) async {
    List<Watchlist>? watchlists = await getWatchlists(requestBuilder, false);
    if (watchlists == null) {
      return;
    }
    for (Watchlist watchlist in watchlists) {
      await deleteWatchlist(requestBuilder, watchlist.id);
    }
  }

  /// Performs a delete of a specific watchlist matching
  /// the [watchlistId] provided. To remove a specific asset, include
  /// its [symbol] as a parameter.
  static Future<void> deleteWatchlist(
      RequestBuilder requestBuilder, String watchlistId,
      {String? symbol}) async {
    String endpoint = "v2/watchlists/$watchlistId";
    if (symbol != null) {
      endpoint += "/$symbol";
    }
    await requestBuilder.delete(endpoint);
  }

  /// Performs a delete of a specific watchlist's symbol matching
  /// the [watchlistId] and [symbol] provided.
  static Future<void> deleteWatchlistSymbol(
      RequestBuilder requestBuilder, String watchlistId, String symbol) async {
    await deleteWatchlist(requestBuilder, watchlistId, symbol: symbol);
  }
}
