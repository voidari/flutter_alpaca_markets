library alpaca_markets;

import 'dart:convert';
import 'dart:io';

import 'package:alpaca_markets/src/models/asset.dart';
import 'package:alpaca_markets/src/request_builder.dart';
import 'package:http/http.dart' as http;

/// The class used for all asset related requests and parsing.
class AssetsManager {
  /// Get a list of assets.
  /// Optional [status], e.g. “active”. By default, all statuses are included.
  /// Optional [assetClass], defaults to 'us_equity'.
  /// Optional [exchange], AMEX, ARCA, BATS, NYSE, NASDAQ, NYSEARCA or OTC.
  /// Return the list of assets, or null if an error ocurred.
  static Future<List<Asset>?> getAssets(RequestBuilder requestBuilder,
      String? status, String? assetClass, String? exchange) async {
    Map<String, dynamic> params = {};
    if (status != null) {
      params.putIfAbsent("status", () => status);
    }
    if (assetClass != null) {
      params.putIfAbsent("asset_class", () => assetClass);
    }
    if (status != null) {
      params.putIfAbsent("exchange", () => exchange);
    }
    http.Response response =
        await requestBuilder.get("v2/assets", params: params);
    List<Asset> assets = <Asset>[];
    if (HttpStatus.ok != response.statusCode) {
      return null;
    }
    dynamic json = jsonDecode(response.body);
    for (dynamic jsonAsset in json) {
      Asset? asset = Asset.fromMap(jsonAsset);
      if (asset != null) {
        assets.add(asset);
      }
    }
    return assets;
  }

  /// Get a specific asset based on the provided [symbol].
  static Future<Asset?> getAsset(
      RequestBuilder requestBuilder, String symbol) async {
    http.Response response = await requestBuilder.get("v2/assets/$symbol");
    if (HttpStatus.ok != response.statusCode) {
      return null;
    }
    dynamic json = jsonDecode(response.body);
    return Asset.fromMap(json);
  }
}
