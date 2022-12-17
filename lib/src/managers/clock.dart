// Copyright (C) 2022 by Voidari LLC or its subsidiaries.
library alpaca_markets;

/// Used for retrieving clock related content.

import 'dart:convert';
import 'dart:io';

import 'package:alpaca_markets/src/context.dart';
import 'package:alpaca_markets/src/models/clock.dart';
import 'package:alpaca_markets/src/request_builder.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

/// Retrieves the market clock for the current date/time.
Future<Tuple2<int, Clock?>> getMarketClock(Context context) async {
  http.Response response = await RequestBuilder.get(context, "v2/clock");
  if (HttpStatus.ok != response.statusCode) {
    return Tuple2(response.statusCode, null);
  }
  dynamic json = jsonDecode(response.body);
  return Tuple2(response.statusCode, Clock.fromMap(json));
}
