// Copyright (C) 2022 by Voidari LLC or its subsidiaries.
library alpaca_markets;

/// Used for all asset related requests and parsing.

import 'dart:convert';
import 'dart:io';

import 'package:alpaca_markets/src/context.dart';
import 'package:alpaca_markets/src/models/asset.dart';
import 'package:alpaca_markets/src/request_builder.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

/// Get a list of assets.
/// Optional [status], e.g. “active”. By default, all statuses are included.
/// Optional [assetClass], defaults to 'us_equity'.
/// Optional [exchange], AMEX, ARCA, BATS, NYSE, NASDAQ, NYSEARCA or OTC.
/// Return the list of assets, or null if an error ocurred.
Future<Tuple2<int, List<Asset>?>> getAssets(Context context,
    {String? status, String? assetClass, String? exchange}) async {
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
      await RequestBuilder.get(context, "v2/assets", params: params);
  List<Asset> assets = <Asset>[];
  if (HttpStatus.ok != response.statusCode) {
    return Tuple2(response.statusCode, null);
  }
  dynamic json = jsonDecode(response.body);
  for (dynamic jsonAsset in json) {
    Asset? asset = Asset.fromMap(jsonAsset);
    if (asset != null) {
      assets.add(asset);
    }
  }
  return Tuple2(response.statusCode, assets);
}

/// Get a specific asset based on the provided [symbol].
Future<Tuple2<int, Asset?>> getAsset(Context context, String symbol) async {
  http.Response response =
      await RequestBuilder.get(context, "v2/assets/$symbol");
  if (HttpStatus.ok != response.statusCode) {
    return Tuple2(response.statusCode, null);
  }
  dynamic json = jsonDecode(response.body);
  return Tuple2(response.statusCode, Asset.fromMap(json));
}
