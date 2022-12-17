library alpaca_markets;

import 'package:alpaca_markets/src/context.dart';

export 'package:alpaca_markets/src/context.dart';
export 'package:alpaca_markets/src/managers/account_configs.dart';
export 'package:alpaca_markets/src/managers/account.dart';
export 'package:alpaca_markets/src/managers/asset.dart';
export 'package:alpaca_markets/src/managers/calendar.dart';
export 'package:alpaca_markets/src/managers/clock.dart';
export 'package:alpaca_markets/src/managers/corporate_actions_announcements.dart';
export 'package:alpaca_markets/src/managers/portfolio_history.dart';
export 'package:alpaca_markets/src/managers/watchlist.dart';
export 'package:alpaca_markets/src/models/account.dart';
export 'package:alpaca_markets/src/models/account_configs.dart';
export 'package:alpaca_markets/src/models/announcement.dart';
export 'package:alpaca_markets/src/models/asset.dart';
export 'package:alpaca_markets/src/models/calendar.dart';
export 'package:alpaca_markets/src/models/clock.dart';
export 'package:alpaca_markets/src/models/portfolio_history.dart';
export 'package:alpaca_markets/src/models/watchlist.dart';

/// Used to create a live context using the provided [apcaApiKeyId]
/// and [apcaApiSecretKey] keys. Using this context will result in trades
/// being made using real money.
Context createLiveContext(String apcaApiKeyId, String apcaApiSecretKey) {
  return Context(apcaApiKeyId, apcaApiSecretKey, true);
}

/// Used to create a paper context using the provided [apcaApiKeyId]
/// and [apcaApiSecretKey] keys. Using this context will result in trades
/// being made with fake money.
Context createPaperContext(String apcaApiKeyId, String apcaApiSecretKey) {
  return Context(apcaApiKeyId, apcaApiSecretKey, false);
}
