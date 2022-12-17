// Copyright (C) 2022 by Voidari LLC or its subsidiaries.
library alpaca_markets;

/// Used for retrieving calendar related content.

import 'dart:convert';
import 'dart:io';

import 'package:alpaca_markets/src/context.dart';
import 'package:alpaca_markets/src/models/calendar.dart';
import 'package:alpaca_markets/src/request_builder.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

/// Retrieves a market calendar for the specified [date].
/// Returns a calendar or null.
Future<Tuple2<int, Calendar?>> getCalendarDate(
    Context context, DateTime date) async {
  Tuple2<int, List<Calendar>?> response =
      await getCalendarDates(context, start: date, end: date);
  if (response.item2 == null || response.item2!.isEmpty) {
    return Tuple2(response.item1, null);
  }
  return Tuple2(response.item1, response.item2![0]);
}

/// Retrives a list of market calendars from provided [start],
/// or 1970 if not provided, to the provided [end], or 2029 if not provided.
/// Returns the list of calendars.
Future<Tuple2<int, List<Calendar>?>> getCalendarDates(Context context,
    {DateTime? start, DateTime? end}) async {
  if (start == null && end == null) {
    return const Tuple2(600, null);
  }
  Map<String, dynamic> params = {};
  if (start != null) {
    params.putIfAbsent("start", () => start.toString());
  }
  if (end != null) {
    params.putIfAbsent("end", () => end.toString());
  }
  http.Response response =
      await RequestBuilder.get(context, "v2/calendar", params: params);
  if (HttpStatus.ok != response.statusCode) {
    return Tuple2(response.statusCode, null);
  }
  dynamic json = jsonDecode(response.body);
  List<Calendar> calendars = <Calendar>[];
  for (dynamic jsonCalendar in json) {
    Calendar? calendar = Calendar.fromMap(jsonCalendar);
    if (calendar != null) {
      calendars.add(calendar);
    }
  }
  return Tuple2(response.statusCode, calendars);
}
