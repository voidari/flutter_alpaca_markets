library alpaca_markets;

import 'package:alpaca_markets/src/settings.dart';

/// The resolution of time window.
enum Timeframe { min1, min5, min15, hour1, day1, unknown }

/// A timeseries data for equity and profit loss information of an account.
class PortfolioHistory {
  static const String _keyTimestamp = "timestamp";
  static const String _keyEquity = "equity";
  static const String _keyProfitLoss = "profit_loss";
  static const String _keyProfitLossPercent = "profit_loss_pct";
  static const String _keyBaseValue = "base_value";
  static const String _keyTimeframe = "timeframe";

  /// Time of each data element, left-labeled (the beginning of time window).
  final List<DateTime> timestampList;

  /// Equity value of the account in dollar amount as of the end of
  /// each time window.
  final List<double> equityList;

  /// Profit/loss in dollar from the base value.
  final List<double> profitLossList;

  /// Profit/loss in percentage from the base value.
  final List<double> profitLossPercentList;

  /// Basis in dollar of the profit loss calculation.
  final double baseValue;

  /// Time window size of each data element.
  final Timeframe timeframe;

  /// The constructor of the portfolio history.
  PortfolioHistory(this.timestampList, this.equityList, this.profitLossList,
      this.profitLossPercentList, this.baseValue, this.timeframe);

  /// Constructs a clock from the provided map.
  static PortfolioHistory? fromMap(Map<String, dynamic> map) {
    try {
      List<DateTime> timestampList = <DateTime>[];
      for (int epoch in map[_keyTimestamp]) {
        timestampList
            .add(DateTime.fromMillisecondsSinceEpoch((epoch * 1000).toInt()));
      }
      List<double> equityList = <double>[];
      for (dynamic equity in map[_keyEquity]) {
        equityList.add(equity.toDouble());
      }
      List<double> profitLossList = <double>[];
      for (dynamic profitLoss in map[_keyProfitLoss]) {
        profitLossList.add(profitLoss.toDouble());
      }
      List<double> profitLossPercentList = <double>[];
      for (dynamic profitLossPercent in map[_keyProfitLossPercent]) {
        profitLossPercentList.add(profitLossPercent.toDouble());
      }
      double baseValue = map[_keyBaseValue].toDouble();
      Timeframe timeframe = _toTimeframe(map[_keyTimeframe]);
      return PortfolioHistory(timestampList, equityList, profitLossList,
          profitLossPercentList, baseValue, timeframe);
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
    List<int> timestamps = <int>[];
    for (DateTime dt in timestampList) {
      timestamps.add(dt.millisecondsSinceEpoch ~/ 1000);
    }
    map.putIfAbsent(_keyTimestamp, () => timestamps);
    map.putIfAbsent(_keyEquity, () => equityList);
    map.putIfAbsent(_keyProfitLoss, () => profitLossList);
    map.putIfAbsent(_keyProfitLossPercent, () => profitLossPercentList);
    map.putIfAbsent(_keyBaseValue, () => baseValue);
    map.putIfAbsent(_keyTimeframe, () => fromTimeframe(timeframe));
    return map;
  }

  /// Utility for converting from a string to a timeframe.
  static Timeframe _toTimeframe(String timeframe) {
    if ("1Min" == timeframe) {
      return Timeframe.min1;
    } else if ("5Min" == timeframe) {
      return Timeframe.min5;
    } else if ("15Min" == timeframe) {
      return Timeframe.min15;
    } else if ("1H" == timeframe) {
      return Timeframe.hour1;
    } else if ("1D" == timeframe) {
      return Timeframe.day1;
    } else {
      return Timeframe.unknown;
    }
  }

  /// Utility for converting from a timeframe to a string.
  static String fromTimeframe(Timeframe timeframe) {
    if (Timeframe.min1 == timeframe) {
      return "1Min";
    } else if (Timeframe.min5 == timeframe) {
      return "5Min";
    } else if (Timeframe.min15 == timeframe) {
      return "15Min";
    } else if (Timeframe.hour1 == timeframe) {
      return "1H";
    } else if (Timeframe.day1 == timeframe) {
      return "1D";
    } else {
      return "";
    }
  }
}
