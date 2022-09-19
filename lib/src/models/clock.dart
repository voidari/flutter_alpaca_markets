library alpaca_markets;

/// Represents whether the market is open with the current timestamp,
/// also indicating when the market next opens and closes.
class Clock {
  static const String _jsonKeyTimestamp = "timestamp";
  static const String _jsonKeyIsOpen = "is_open";
  static const String _jsonKeyNextOpen = "next_open";
  static const String _jsonKeyNextClose = "next_close";

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
  static Clock? fromMap(Map<String, dynamic> json) {
    try {
      DateTime timestamp = DateTime.parse(json[_jsonKeyTimestamp]!);
      bool isOpen = json[_jsonKeyIsOpen]!;
      DateTime nextOpen = DateTime.parse(json[_jsonKeyNextOpen]!);
      DateTime nextClose = DateTime.parse(json[_jsonKeyNextClose]!);
      return Clock(timestamp, isOpen, nextOpen, nextClose);
    } catch (error) {
      return null;
    }
  }

  /// Creates a map given the current clock data
  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {};
    json.putIfAbsent(_jsonKeyTimestamp, () => timestamp.toUtc().toString());
    json.putIfAbsent(_jsonKeyIsOpen, () => isOpen);
    json.putIfAbsent(_jsonKeyNextOpen, () => nextOpen.toUtc().toString());
    json.putIfAbsent(_jsonKeyNextClose, () => nextClose.toUtc().toString());
    return json;
  }
}
