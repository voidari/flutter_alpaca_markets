library alpaca_markets;

import 'package:alpaca_markets/src/managers/account_configs_manager.dart';
import 'package:alpaca_markets/src/managers/account_manager.dart';
import 'package:alpaca_markets/src/managers/asset_manager.dart';
import 'package:alpaca_markets/src/managers/calendar_manager.dart';
import 'package:alpaca_markets/src/managers/clock_manager.dart';
import 'package:alpaca_markets/src/managers/watchlist_manager.dart';
import 'package:alpaca_markets/src/models/account.dart';
import 'package:alpaca_markets/src/models/account_configs.dart';
import 'package:alpaca_markets/src/models/asset.dart';
import 'package:alpaca_markets/src/models/calendar.dart';
import 'package:alpaca_markets/src/models/clock.dart';
import 'package:alpaca_markets/src/models/watchlist.dart';
import 'package:alpaca_markets/src/request_builder.dart';

export './src/models/account.dart';
export './src/models/account_configs.dart';
export './src/models/asset.dart';
export './src/models/calendar.dart';
export './src/models/clock.dart';
export './src/models/watchlist.dart';

/// Provides a means to trade with Alpaca's brokerage service,
/// allowing access to real-time price, fundamentals, placing orders,
/// and managing a portfolio.
class AlpacaMarkets {
  /// The client credential keys
  late RequestBuilder _requestBuilder;

  /// The constructor for the market instance for the provided
  /// client credentials. Credentials are not saved on the device,
  /// and will be lost when the AlpacaMarkets instanace is destroyed.
  /// If only paper credentials are provided, paper trading will be enabled.
  ///
  /// Live trading is enabled by default.
  ///
  /// The paper trading keys are separate from the live trading keys,
  /// and must be generated in their own environment.
  ///
  /// Provide [liveApacApiKeyId], the API key ID, and [liveApcaApiSecretKey],
  /// the API secret key, for the live environment.
  /// [paperApacApiKeyId] and [paperApcaApiSecretKey] are for the paper environment.
  AlpacaMarkets(
      {final String? liveApacApiKeyId,
      final String? liveApcaApiSecretKey,
      final String? paperApacApiKeyId,
      final String? paperApcaApiSecretKey}) {
    Credentials? liveCredentials;
    Credentials? paperCredentials;
    if (liveApacApiKeyId != null && liveApcaApiSecretKey != null) {
      liveCredentials = Credentials(liveApacApiKeyId, liveApcaApiSecretKey);
    }
    if (paperApacApiKeyId != null && paperApcaApiSecretKey != null) {
      paperCredentials = Credentials(paperApacApiKeyId, paperApcaApiSecretKey);
    }
    _requestBuilder = RequestBuilder(liveCredentials, paperCredentials);
    if (liveCredentials == null && paperCredentials != null) {
      _requestBuilder.enablePaperTrading();
    }
  }

  /// Provides a means to update the credentials for either live or
  /// paper trading platforms.
  /// Use [apcaApiKeyId] and [apcaApiSecretKey] to update the credentials
  /// for the optional [isLive] environment.
  void updateCredentials(
      final String apcaApiKeyId, final String apcaApiSecretKey,
      {bool isLive = true}) {
    _requestBuilder.updateCredentials(
        Credentials(apcaApiKeyId, apcaApiSecretKey),
        isLive: isLive);
  }

  /// Enable live trading for real world transaction requests.
  void enableLiveTrading() {
    _requestBuilder.enableLiveTrading();
  }

  /// Enable paper trading to avoid real transaction requests.
  void enablePaperTrading() {
    _requestBuilder.enablePaperTrading();
  }

  /// Returns the account associated with the API key.
  Future<Account?> getAccount() async {
    return await AccountManager.getAccount(_requestBuilder);
  }

  /// Get a list of assets.
  /// Optional [status], e.g. “active”. By default, all statuses are included.
  /// Optional [assetClass], defaults to 'us_equity'.
  /// Optional [exchange], AMEX, ARCA, BATS, NYSE, NASDAQ, NYSEARCA or OTC.
  /// Return the list of assets, or null if an error ocurred.
  Future<List<Asset>?> getAssets(
      {String? status, String? assetClass, String? exchange}) async {
    return await AssetsManager.getAssets(
        _requestBuilder, status, assetClass, exchange);
  }

  /// Get a specific asset based on the provided [symbol]. Null will
  /// be returned if the symbol was not found, or if an error ocurred.
  Future<Asset?> getAsset(String symbol) async {
    return await AssetsManager.getAsset(_requestBuilder, symbol);
  }

  /// Returns the list of watchlists registered under the account.
  /// Assets under each watchlist will NOT be included by default. Use
  /// the parameter [withAssets] to have them included. This will take
  /// longer, as it requires making individual requests to each watchlist
  /// after the initial list request.
  Future<List<Watchlist>?> getWatchlists({bool withAssets = false}) async {
    return await WatchlistManager.getWatchlists(_requestBuilder, withAssets);
  }

  /// Returns a watchlist identified by the [watchlistId].
  Future<Watchlist?> getWatchlist(String watchlistId) async {
    return await WatchlistManager.getWatchlist(_requestBuilder, watchlistId);
  }

  /// Create a new watchlist with the provided [name] and optionally with
  /// an initial set of assets using the [symbols] list.
  /// Returns the created watchlist.
  Future<Watchlist?> createWatchlist(String name,
      {List<String>? symbols}) async {
    return await WatchlistManager.createWatchlist(_requestBuilder, name,
        symbols: symbols);
  }

  /// Update the name with [name] and/or content of watchlist with new [symbols]
  /// of the watchlist specified by the [watchlistId]. Providing [symbols] will
  /// replace ALL existing symbols, so it should be the complete list of symbols
  /// you want.
  /// Returns the edited watchlist.
  Future<Watchlist?> updateWatchlist(String watchlistId,
      {String? name, List<String>? symbols}) async {
    return await WatchlistManager.updateWatchlist(_requestBuilder, watchlistId,
        name: name, symbols: symbols);
  }

  /// Adds the [symbol] asset to the watchlist matching the [watchlistId].
  /// Returns the watchlist with the added asset.
  Future<Watchlist?> addWatchlistSymbol(
      String watchlistId, String symbol) async {
    return await WatchlistManager.addWatchlistSymbol(
        _requestBuilder, watchlistId, symbol);
  }

  /// Perform a delete of all watchlists.
  Future<void> deleteAllWatchlists() async {
    await WatchlistManager.deleteAllWatchlists(_requestBuilder);
  }

  /// Performs a delete of a specific watchlist matching
  /// the [watchlistId] provided. To remove a specific asset, include
  /// its [symbol] as a parameter.
  Future<void> deleteWatchlist(String watchlistId, {String? symbol}) async {
    await WatchlistManager.deleteWatchlist(_requestBuilder, watchlistId,
        symbol: symbol);
  }

  /// Performs a delete of a specific watchlist's symbol matching
  /// the [watchlistId] and [symbol] provided.
  Future<void> deleteWatchlistSymbol(String watchlistId, String symbol) async {
    await WatchlistManager.deleteWatchlistSymbol(
        _requestBuilder, watchlistId, symbol);
  }

  /// Retrieves a market calendar for the specified [date]. If the date
  /// falls on a date that the market is not open, it will return the next
  /// date the market is open.
  /// Returns a calendar or null.
  Future<Calendar?> getCalendarDate(DateTime date) async {
    return await CalendarManager.getDate(_requestBuilder, date);
  }

  /// Retrives a list of market calendars from provided [start],
  /// or 1970 if not provided, to the provided [end], or 2029 if not provided.
  /// Returns the list of calendars.
  Future<List<Calendar>?> getCalendarDates(
      {DateTime? start, DateTime? end}) async {
    return await CalendarManager.getDates(_requestBuilder,
        start: start, end: end);
  }

  /// Retrieves the market clock for the current date/time.
  Future<Clock?> getMarketClock() async {
    return await ClockManager.getMarketClock(_requestBuilder);
  }

  /// Retrieves the account configs for the current account.
  Future<AccountConfigs?> getAccountConfigs() async {
    return await AccountConfigsManager.getAccountConfigs(_requestBuilder);
  }

  /// Provides a method of updating account configs with the desired change
  /// in parameter. See [AccountConfigs] for the possible values for each
  /// of the parameters.
  Future<AccountConfigs?> updateAccountConfigs(
      {String? dtbpCheck,
      String? tradeConfirmEmail,
      bool? suspendTrade,
      bool? noShorting,
      bool? fractionalTrading,
      String? maxMarginMultiplier,
      String? pdtCheck}) async {
    return await AccountConfigsManager.updateAccountConfigs(_requestBuilder,
        dtbpCheck: dtbpCheck,
        tradeConfirmEmail: tradeConfirmEmail,
        suspendTrade: suspendTrade,
        noShorting: noShorting,
        fractionalTrading: fractionalTrading,
        maxMarginMultiplier: maxMarginMultiplier,
        pdtCheck: pdtCheck);
  }
}
