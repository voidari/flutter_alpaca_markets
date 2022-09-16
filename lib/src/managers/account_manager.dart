library alpaca_markets;

import 'dart:convert';
import 'dart:io';

import 'package:alpaca_markets/src/models/account.dart';
import 'package:alpaca_markets/src/request_builder.dart';
import 'package:http/http.dart' as http;

/// The class used for all asset related requests and parsing.
class AccountManager {
  /// Returns the account associated with the API key.
  static Future<Account?> getAccount(RequestBuilder requestBuilder) async {
    http.Response response = await requestBuilder.get("v2/account");
    if (HttpStatus.ok != response.statusCode) {
      return null;
    }
    dynamic json = jsonDecode(response.body);
    return Account.fromJson(json);
  }
}
