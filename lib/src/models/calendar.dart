library alpaca_markets;

import 'package:flutter/material.dart';

/// Contains the specific open and close times for the market days, taking into
/// account early closures.
class Calendar {
  static const String _jsonKeyDate = "date";
  static const String _jsonKeyOpen = "open";
  static const String _jsonKeyClose = "close";

  /// The date being described.
  final DateTime date;

  /// The time the market opens at on this date.
  final TimeOfDay open;

  /// The time the market closes at on this date.
  final TimeOfDay close;

  /// The constructor of the calendar
  Calendar(this.date, this.open, this.close);

  /// Constructs a calendar from the provided JSON data.
  static Calendar? fromJson(Map<String, dynamic> json) {
    try {
      DateTime date = DateTime.parse(json[_jsonKeyDate]!);
      TimeOfDay open = TimeOfDay(
          hour: int.parse(json[_jsonKeyOpen]!.split(":")[0]),
          minute: int.parse(json[_jsonKeyOpen]!.split(":")[1]));
      TimeOfDay close = TimeOfDay(
          hour: int.parse(json[_jsonKeyClose]!.split(":")[0]),
          minute: int.parse(json[_jsonKeyClose]!.split(":")[1]));
      return Calendar(date, open, close);
    } catch (error) {
      return null;
    }
  }

  /// Creates a JSON object given the current calendar data
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json.putIfAbsent(_jsonKeyDate, () => date.toUtc().toString());
    json.putIfAbsent(_jsonKeyOpen, () => open.toString());
    json.putIfAbsent(_jsonKeyClose, () => close.toString());
    return json;
  }
}
