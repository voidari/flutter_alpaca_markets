library alpaca_markets;

/// The following are the possible account status values. Most likely,
/// the account status is ACTIVE unless there is any problem. The account
/// status may get in ACCOUNT_UPDATED when personal information is being
/// updated from the dashboard, in which case you may not be allowed trading
/// for a short period of time until the change is approved.
enum AccountStatus {
  /// The account is onboarding.
  onboarding,

  /// The account application submission failed for some reason.
  submissionFailed,

  /// The account application has been submitted for review.
  submitted,

  /// The account information is being updated.
  accountUpdated,

  /// The final account approval is pending.
  approvalPending,

  /// The account is active for trading.
  active,

  /// The account application has been rejected.
  rejected,

  /// The unknown value. An error ocurred.
  unknown
}

/// The account API serves important information related to an account,
/// including account status, funds available for trade, funds available
/// for withdrawal, and various flags relevant to an account’s ability
/// to trade.
class Account {
  static const String _keyId = "id";
  static const String _keyAccountNumber = "account_number";
  static const String _keyStatus = "status";
  static const String _keyCurrency = "currency";
  static const String _keyCash = "cash";
  static const String _keyPortfolioValue = "portfolio_value";
  static const String _keyPatternDayTrader = "pattern_day_trader";
  static const String _keyTradeSuspendedByUser = "trade_suspended_by_user";
  static const String _keyTradingBlocked = "trading_blocked";
  static const String _keyTransfersBlocked = "transfers_blocked";
  static const String _keyAccountBlocked = "account_blocked";
  static const String _keyCreatedAt = "created_at";
  static const String _keyShortingEnabled = "shorting_enabled";
  static const String _keyLongMarketValue = "long_market_value";
  static const String _keyShortMarketValue = "short_market_value";
  static const String _keyEquity = "equity";
  static const String _keyLastEquity = "last_equity";
  static const String _keyMultiplier = "multiplier";
  static const String _keyBuyingPower = "buying_power";
  static const String _keyInitialMargin = "initial_margin";
  static const String _keyMaintenanceMargin = "maintenance_margin";
  static const String _keySma = "sma";
  static const String _keyDaytradeCount = "daytrade_count";
  static const String _keyLastMaintenanceMargin = "last_maintenance_margin";
  static const String _keyDayTradingBuyingPower = "daytrading_buying_power";
  static const String _keyRegtBuyingPower = "regt_buying_power";

  /// Account ID.
  final String id;

  /// Account number.
  final String accountNumber;

  /// See the definition for [AccountStatus].
  final AccountStatus status;

  /// The currency symbol, ex: "USD".
  final String currency;

  /// The cash balance. This value is a number.
  final String cash;

  /// Total value of cash + holding positions (This field is deprecated.
  /// It is equivalent to the equity field.)
  /// This value is a number.
  final String portfolioValue;

  ///Whether or not the account has been flagged as a pattern day trader.
  final bool patternDayTrader;

  /// User setting. If true, the account is not allowed to place orders.
  final bool tradeSuspendedByUser;

  /// If true, the account is not allowed to place orders.
  final bool tradingBlocked;

  /// If true, the account is not allowed to request money transfers.
  final bool transfersBlocked;

  /// If true, the account activity by user is prohibited.
  final bool accountBlocked;

  /// Timestamp this account was created at.
  final DateTime createdAt;

  /// Flag to denote whether or not the account is permitted to short.
  final bool shortingEnabled;

  /// Real-time MtM value of all long positions held in the account.
  /// This value is a number.
  final String longMarketValue;

  /// Real-time MtM value of all short positions held in the account.
  /// This value is a number.
  final String shortMarketValue;

  /// Cash + long_market_value + short_market_value.
  /// This value is a number.
  final String equity;

  /// Equity as of previous trading day at 16:00:00 ET.
  /// This value is a number.
  final String lastEquity;

  /// Buying power multiplier that represents account margin classification;
  /// valid values 1 (standard limited margin account with 1x buying power),
  /// 2 (reg T margin account with 2x intraday and overnight buying power;
  /// this is the default for all non-PDT accounts with $2,000 or more equity),
  /// 4 (PDT account with 4x intraday buying power and 2x reg T overnight
  /// buying power).
  /// This value is a number.
  final String multiplier;

  /// Current available $ buying power; If multiplier = 4, this is your
  /// daytrade buying power which is calculated as
  /// (last_equity - (last) maintenance_margin) * 4;
  /// If multiplier = 2, buying_power = max(equity – initial_margin,0) * 2;
  /// If multiplier = 1, buying_power = cash.
  /// This value is a number.
  final String buyingPower;

  /// Reg T initial margin requirement (continuously updated value).
  /// This value is a number.
  final String initialMargin;

  /// Maintenance margin requirement (continuously updated value).
  /// This value is a number.
  final String maintenanceMargin;

  /// Value of special memorandum account (will be used at a later date
  /// to provide additional buying_power).
  /// This value is a number.
  final String sma;

  /// The current number of daytrades that have been made in the last 5
  /// trading days (inclusive of today).
  final int daytradeCount;

  /// Your maintenance margin requirement on the previous trading day.
  /// This value is a number.
  final String lastMaintenanceMargin;

  /// Your buying power for day trades (continuously updated value).
  /// This value is a number.
  final String daytradingBuyingPower;

  /// Your buying power under Regulation T (your excess equity - equity
  /// minus margin value - times your margin multiplier).
  /// This value is a number.
  final String regtBuyingPower;

  /// The constructor for an Account
  Account(
      this.id,
      this.accountNumber,
      this.status,
      this.currency,
      this.cash,
      this.portfolioValue,
      this.patternDayTrader,
      this.tradeSuspendedByUser,
      this.tradingBlocked,
      this.transfersBlocked,
      this.accountBlocked,
      this.createdAt,
      this.shortingEnabled,
      this.longMarketValue,
      this.shortMarketValue,
      this.equity,
      this.lastEquity,
      this.multiplier,
      this.buyingPower,
      this.initialMargin,
      this.maintenanceMargin,
      this.sma,
      this.daytradeCount,
      this.lastMaintenanceMargin,
      this.daytradingBuyingPower,
      this.regtBuyingPower);

  /// Constructs an asset from the provided map.
  static Account? fromMap(Map<String, dynamic> map) {
    try {
      String id = map[_keyId]!;
      String accountNumber = map[_keyAccountNumber]!;
      AccountStatus status = _toAccountStatus(map[_keyStatus]!);
      String currency = map[_keyCurrency]!;
      String cash = map[_keyCash]!;
      String portfolioValue = map[_keyPortfolioValue]!;
      bool patternDayTrader = map[_keyPatternDayTrader]!;
      bool tradeSuspendedByUser = map[_keyTradeSuspendedByUser]!;
      bool tradingBlocked = map[_keyTradingBlocked]!;
      bool transfersBlocked = map[_keyTransfersBlocked]!;
      bool accountBlocked = map[_keyAccountBlocked]!;
      DateTime createdAt = DateTime.parse(map[_keyCreatedAt]!);
      bool shortingEnabled = map[_keyShortingEnabled]!;
      String longMarketValue = map[_keyLongMarketValue]!;
      String shortMarketValue = map[_keyShortMarketValue]!;
      String equity = map[_keyEquity]!;
      String lastEquity = map[_keyLastEquity]!;
      String multiplier = map[_keyMultiplier]!;
      String buyingPower = map[_keyBuyingPower]!;
      String initialMargin = map[_keyInitialMargin]!;
      String maintenanceMargin = map[_keyMaintenanceMargin]!;
      String sma = map[_keySma]!;
      int daytradeCount = map[_keyDaytradeCount]!;
      String lastMaintenanceMargin = map[_keyLastMaintenanceMargin]!;
      String daytradingBuyingPower = map[_keyDayTradingBuyingPower]!;
      String regtBuyingPower = map[_keyRegtBuyingPower]!;
      // Create the account
      return Account(
          id,
          accountNumber,
          status,
          currency,
          cash,
          portfolioValue,
          patternDayTrader,
          tradeSuspendedByUser,
          tradingBlocked,
          transfersBlocked,
          accountBlocked,
          createdAt,
          shortingEnabled,
          longMarketValue,
          shortMarketValue,
          equity,
          lastEquity,
          multiplier,
          buyingPower,
          initialMargin,
          maintenanceMargin,
          sma,
          daytradeCount,
          lastMaintenanceMargin,
          daytradingBuyingPower,
          regtBuyingPower);
    } catch (error) {
      return null;
    }
  }

  /// Creates a map given the current asset data
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map.putIfAbsent(_keyId, () => id);
    map.putIfAbsent(_keyAccountNumber, () => accountNumber);
    map.putIfAbsent(_keyStatus, () => _fromAccountStatus(status));
    map.putIfAbsent(_keyCurrency, () => currency);
    map.putIfAbsent(_keyCash, () => cash);
    map.putIfAbsent(_keyPortfolioValue, () => portfolioValue);
    map.putIfAbsent(_keyPatternDayTrader, () => patternDayTrader);
    map.putIfAbsent(_keyTradeSuspendedByUser, () => tradeSuspendedByUser);
    map.putIfAbsent(_keyTradingBlocked, () => tradingBlocked);
    map.putIfAbsent(_keyTransfersBlocked, () => transfersBlocked);
    map.putIfAbsent(_keyAccountBlocked, () => accountBlocked);
    map.putIfAbsent(_keyCreatedAt, () => createdAt.toUtc().toString());
    map.putIfAbsent(_keyShortingEnabled, () => shortingEnabled);
    map.putIfAbsent(_keyLongMarketValue, () => longMarketValue);
    map.putIfAbsent(_keyShortMarketValue, () => shortMarketValue);
    map.putIfAbsent(_keyEquity, () => equity);
    map.putIfAbsent(_keyLastEquity, () => lastEquity);
    map.putIfAbsent(_keyMultiplier, () => multiplier);
    map.putIfAbsent(_keyBuyingPower, () => buyingPower);
    map.putIfAbsent(_keyInitialMargin, () => initialMargin);
    map.putIfAbsent(_keyMaintenanceMargin, () => maintenanceMargin);
    map.putIfAbsent(_keySma, () => sma);
    map.putIfAbsent(_keyDaytradeCount, () => daytradeCount);
    map.putIfAbsent(_keyLastMaintenanceMargin, () => lastMaintenanceMargin);
    map.putIfAbsent(_keyDayTradingBuyingPower, () => daytradingBuyingPower);
    map.putIfAbsent(_keyRegtBuyingPower, () => regtBuyingPower);
    return map;
  }

  /// Utility to convert the string to an account status.
  static AccountStatus _toAccountStatus(String status) {
    if ("ONBOARDING" == status) {
      return AccountStatus.onboarding;
    } else if ("SUBMISSION_FAILED" == status) {
      return AccountStatus.submissionFailed;
    } else if ("SUBMITTED" == status) {
      return AccountStatus.submitted;
    } else if ("ACCOUNT_UPDATED" == status) {
      return AccountStatus.accountUpdated;
    } else if ("APPROVAL_PENDING" == status) {
      return AccountStatus.approvalPending;
    } else if ("ACTIVE" == status) {
      return AccountStatus.active;
    } else if ("REJECTED" == status) {
      return AccountStatus.rejected;
    } else {
      return AccountStatus.unknown;
    }
  }

  /// Utility to convert the account status to a string.
  static String _fromAccountStatus(AccountStatus status) {
    if (AccountStatus.onboarding == status) {
      return "ONBOARDING";
    } else if (AccountStatus.submissionFailed == status) {
      return "SUBMISSION_FAILED";
    } else if (AccountStatus.submitted == status) {
      return "SUBMITTED";
    } else if (AccountStatus.accountUpdated == status) {
      return "ACCOUNT_UPDATED";
    } else if (AccountStatus.approvalPending == status) {
      return "APPROVAL_PENDING";
    } else if (AccountStatus.active == status) {
      return "ACTIVE";
    } else if (AccountStatus.rejected == status) {
      return "REJECTED";
    } else {
      return "UNKNOWN";
    }
  }
}
