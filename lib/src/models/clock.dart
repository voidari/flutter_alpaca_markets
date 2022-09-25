library alpaca_markets;

import 'package:alpaca_markets/src/settings.dart';

/// Represents whether the market is open with the current timestamp,
/// also indicating when the market next opens and closes.
class Clock {
  static const String _keyTimestamp = "timestamp";
  static const String _keyIsOpen = "is_open";
  static const String _keyNextOpen = "next_open";
  static const String _keyNextClose = "next_close";

  /// The timestamp being described.
  final DateTime timestamp;

  /// Whether or not the market is open.
  final bool isOpen;

  /// The next market open timestamp.
  final DateTime nextOpen;

  /// The next market open timestamp.
  final DateTime nextClose;

  /// The constructor of the clock.
  Clock(this.timestamp, this.isOpen, this.nextOpen, this.nextClose);

  /// Constructs a clock from the provided map.
  static Clock? fromMap(Map<String, dynamic> map) {
    try {
      DateTime timestamp = DateTime.parse(map[_keyTimestamp]);
      bool isOpen = map[_keyIsOpen];
      DateTime nextOpen = DateTime.parse(map[_keyNextOpen]);
      DateTime nextClose = DateTime.parse(map[_keyNextClose]);
      return Clock(timestamp, isOpen, nextOpen, nextClose);
    } catch (error) {
      if (Settings.debugPrint) {
        // ignore: avoid_print
        print(error);
      }
      return null;
    }
  }

  /// Creates a map given the current clock data
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map.putIfAbsent(_keyTimestamp, () => timestamp.toUtc().toString());
    map.putIfAbsent(_keyIsOpen, () => isOpen);
    map.putIfAbsent(_keyNextOpen, () => nextOpen.toUtc().toString());
    map.putIfAbsent(_keyNextClose, () => nextClose.toUtc().toString());
    return map;
  }
}
