// Copyright (C) 2022 by Voidari LLC or its subsidiaries.
library alpaca_markets;

/// Used for retrieving portfolio history related content.

import 'dart:convert';
import 'dart:io';

import 'package:alpaca_markets/src/context.dart';
import 'package:alpaca_markets/src/models/portfolio_history.dart';
import 'package:alpaca_markets/src/request_builder.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

/// Returns the timeseries data for equity and profit loss information
/// of the account. Provide a [periodDay], [periodWeek], [periodMonth], or
/// [periodYear] for the duration of data. Defaults to 1 month. Set the
/// [timeframe] for the resolution of time window. If omitted, 1Min for less
/// than 7 days period, 15Min for less than 30 days, or otherwise 1D.
/// Set [dateEnd] as the date the data is returned up to. Defaults to the
/// current market date (rolls over at the market open if extended_hours is
/// false, otherwise at 7am ET).
/// Set the [extendedHours] to true to include extended hours in the result.
/// This is effective only for timeframe less than 1D.
Future<Tuple2<int, PortfolioHistory?>> getPortfolioHistory(Context context,
    {int? periodDay,
    int? periodWeek,
    int? periodMonth,
    int? periodYear,
    Timeframe? timeframe,
    DateTime? dateEnd,
    bool? extendedHours}) async {
  Map<String, dynamic> params = <String, dynamic>{};
  if (periodDay != null) {
    params.putIfAbsent("period", () => "${periodDay}D");
  } else if (periodWeek != null) {
    params.putIfAbsent("period", () => "${periodWeek}W");
  } else if (periodMonth != null) {
    params.putIfAbsent("period", () => "${periodMonth}M");
  } else if (periodYear != null) {
    params.putIfAbsent("period", () => "${periodYear}A");
  }
  if (timeframe != null) {
    params.putIfAbsent(
        "timeframe", () => PortfolioHistory.fromTimeframe(timeframe));
  }
  if (dateEnd != null) {
    params.putIfAbsent(
        "date_end", () => DateFormat('yyyy-MM-dd').format(dateEnd));
  }
  if (extendedHours != null) {
    params.putIfAbsent("extended_hours", () => extendedHours);
  }
  http.Response response =
      await RequestBuilder.get(context, "v2/account/portfolio/history");
  if (HttpStatus.ok != response.statusCode) {
    return Tuple2(response.statusCode, null);
  }
  dynamic json = jsonDecode(response.body);
  return Tuple2(response.statusCode, PortfolioHistory.fromMap(json));
}
