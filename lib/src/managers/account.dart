library alpaca_markets;

/// Used for all asset related requests and parsing.

import 'dart:convert';
import 'dart:io';

import 'package:alpaca_markets/src/context.dart';
import 'package:alpaca_markets/src/models/account.dart';
import 'package:alpaca_markets/src/request_builder.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

/// Returns the account associated with the API key.
Future<Tuple2<int, Account?>> getAccount(Context context) async {
  http.Response response = await RequestBuilder.get(context, "v2/account");
  if (HttpStatus.ok != response.statusCode) {
    return Tuple2(response.statusCode, null);
  }
  dynamic json = jsonDecode(response.body);
  return Tuple2(response.statusCode, Account.fromMap(json));
}
