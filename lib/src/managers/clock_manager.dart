library alpaca_markets;

import 'dart:convert';
import 'dart:io';

import 'package:alpaca_markets/src/models/clock.dart';
import 'package:alpaca_markets/src/request_builder.dart';
import 'package:http/http.dart' as http;

/// The class used for retrieving clock related content.
class ClockManager {
  /// Retrieves the market clock for the current date/time.
  static Future<Clock?> getMarketClock(RequestBuilder requestBuilder) async {
    http.Response response = await requestBuilder.get("v2/clock");
    if (HttpStatus.ok != response.statusCode) {
      return null;
    }
    dynamic json = jsonDecode(response.body);
    return Clock.fromJson(json);
  }
}
