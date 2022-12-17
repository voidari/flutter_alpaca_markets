library alpaca_markets;

/// Used for handling account configs related content.

import 'dart:convert';
import 'dart:io';

import 'package:alpaca_markets/src/context.dart';
import 'package:alpaca_markets/src/models/account_configs.dart';
import 'package:alpaca_markets/src/request_builder.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

/// Retrieves the account configs for the current account.
Future<Tuple2<int, AccountConfigs?>> getAccountConfigs(Context context) async {
  http.Response response =
      await RequestBuilder.get(context, "v2/account/configurations");
  if (HttpStatus.ok != response.statusCode) {
    return Tuple2(response.statusCode, null);
  }
  dynamic json = jsonDecode(response.body);
  return Tuple2(response.statusCode, AccountConfigs.fromMap(json));
}

/// Provides a method of updating account configs with the desired change
/// in parameter. See [AccountConfigs] for the possible values for each
/// of the parameters.
Future<Tuple2<int, AccountConfigs?>> updateAccountConfigs(Context context,
    {String? dtbpCheck,
    String? tradeConfirmEmail,
    bool? suspendTrade,
    bool? noShorting,
    bool? fractionalTrading,
    String? maxMarginMultiplier,
    String? pdtCheck}) async {
  Map<String, dynamic> body = {};
  if (dtbpCheck != null) {
    body.putIfAbsent("dtbp_check", () => dtbpCheck);
  }
  if (tradeConfirmEmail != null) {
    body.putIfAbsent("trade_confirm_email", () => tradeConfirmEmail);
  }
  if (suspendTrade != null) {
    body.putIfAbsent("suspend_trade", () => suspendTrade);
  }
  if (noShorting != null) {
    body.putIfAbsent("noShorting", () => noShorting);
  }
  if (fractionalTrading != null) {
    body.putIfAbsent("fractional_trading", () => fractionalTrading);
  }
  if (maxMarginMultiplier != null) {
    body.putIfAbsent("max_margin_multiplier", () => maxMarginMultiplier);
  }
  if (pdtCheck != null) {
    body.putIfAbsent("pdt_check", () => pdtCheck);
  }
  http.Response response = await RequestBuilder.patch(
      context, "v2/account/configurations",
      body: jsonEncode(body));
  if (HttpStatus.ok != response.statusCode) {
    return Tuple2(response.statusCode, null);
  }
  dynamic json = jsonDecode(response.body);
  return Tuple2(response.statusCode, AccountConfigs.fromMap(json));
}
