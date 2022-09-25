library alpaca_markets;

import 'package:alpaca_markets/src/settings.dart';
import 'package:flutter/material.dart';

/// Contains the specific open and close times for the market days, taking into
/// account early closures.
class Calendar {
  static const String _keyDate = "date";
  static const String _keyOpen = "open";
  static const String _keyClose = "close";

  /// The date being described.
  final DateTime date;

  /// The time the market opens at on this date.
  final TimeOfDay open;

  /// The time the market closes at on this date.
  final TimeOfDay close;

  /// The constructor of the calendar
  Calendar(this.date, this.open, this.close);

  /// Constructs a calendar from the provided map.
  static Calendar? fromMap(Map<String, dynamic> map) {
    try {
      DateTime date = DateTime.parse(map[_keyDate]);
      TimeOfDay open = TimeOfDay(
          hour: int.parse(map[_keyOpen].split(":")[0]),
          minute: int.parse(map[_keyOpen].split(":")[1]));
      TimeOfDay close = TimeOfDay(
          hour: int.parse(map[_keyClose].split(":")[0]),
          minute: int.parse(map[_keyClose].split(":")[1]));
      return Calendar(date, open, close);
    } catch (error) {
      if (Settings.debugPrint) {
        // ignore: avoid_print
        print(error);
      }
      return null;
    }
  }

  /// Creates a map given the current calendar data
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map.putIfAbsent(_keyDate, () => date.toUtc().toString());
    map.putIfAbsent(_keyOpen, () => open.toString());
    map.putIfAbsent(_keyClose, () => close.toString());
    return map;
  }
}
