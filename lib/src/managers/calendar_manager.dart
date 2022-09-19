library alpaca_markets;

import 'dart:convert';
import 'dart:io';

import 'package:alpaca_markets/src/models/calendar.dart';
import 'package:alpaca_markets/src/request_builder.dart';
import 'package:http/http.dart' as http;

/// The class used for retrieving calendar related content.
class CalendarManager {
  /// Retrieves a market calendar for the specified [date].
  /// Returns a calendar or null.
  static Future<Calendar?> getDate(
      RequestBuilder requestBuilder, DateTime date) async {
    List<Calendar>? calendars =
        await getDates(requestBuilder, start: date, end: date);
    if (calendars == null || calendars.isEmpty) {
      return null;
    }
    return calendars[0];
  }

  /// Retrives a list of market calendars from provided [start],
  /// or 1970 if not provided, to the provided [end], or 2029 if not provided.
  /// Returns the list of calendars.
  static Future<List<Calendar>?> getDates(RequestBuilder requestBuilder,
      {DateTime? start, DateTime? end}) async {
    if (start == null && end == null) {
      return null;
    }
    Map<String, dynamic> params = {};
    if (start != null) {
      params.putIfAbsent("start", () => start.toString());
    }
    if (end != null) {
      params.putIfAbsent("end", () => end.toString());
    }
    http.Response response =
        await requestBuilder.get("v2/calendar", params: params);
    if (HttpStatus.ok != response.statusCode) {
      return null;
    }
    dynamic json = jsonDecode(response.body);
    List<Calendar> calendars = <Calendar>[];
    for (dynamic jsonCalendar in json) {
      Calendar? calendar = Calendar.fromMap(jsonCalendar);
      if (calendar != null) {
        calendars.add(calendar);
      }
    }
    return calendars;
  }
}
