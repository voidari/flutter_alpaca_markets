library alpaca_markets;

import 'dart:convert';
import 'dart:io';

import 'package:alpaca_markets/src/models/account_configs.dart';
import 'package:alpaca_markets/src/request_builder.dart';
import 'package:http/http.dart' as http;

/// The class used for handling account configs related content.
class AccountConfigsManager {
  /// Retrieves the account configs for the current account.
  static Future<AccountConfigs?> getAccountConfigs(
      RequestBuilder requestBuilder) async {
    http.Response response =
        await requestBuilder.get("v2/account/configurations");
    if (HttpStatus.ok != response.statusCode) {
      return null;
    }
    dynamic json = jsonDecode(response.body);
    return AccountConfigs.fromMap(json);
  }

  /// Provides a method of updating account configs with the desired change
  /// in parameter. See [AccountConfigs] for the possible values for each
  /// of the parameters.
  static Future<AccountConfigs?> updateAccountConfigs(
      RequestBuilder requestBuilder,
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
    http.Response response = await requestBuilder
        .patch("v2/account/configurations", body: jsonEncode(body));
    if (HttpStatus.ok != response.statusCode) {
      return null;
    }
    dynamic json = jsonDecode(response.body);
    return AccountConfigs.fromMap(json);
  }
}
