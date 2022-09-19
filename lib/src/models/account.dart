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
  static const String _jsonKeyId = "id";
  static const String _jsonKeyAccountNumber = "account_number";
  static const String _jsonKeyStatus = "status";
  static const String _jsonKeyCurrency = "currency";
  static const String _jsonKeyCash = "cash";
  static const String _jsonKeyPortfolioValue = "portfolio_value";
  static const String _jsonKeyPatternDayTrader = "pattern_day_trader";
  static const String _jsonKeyTradeSuspendedByUser = "trade_suspended_by_user";
  static const String _jsonKeyTradingBlocked = "trading_blocked";
  static const String _jsonKeyTransfersBlocked = "transfers_blocked";
  static const String _jsonKeyAccountBlocked = "account_blocked";
  static const String _jsonKeyCreatedAt = "created_at";
  static const String _jsonKeyShortingEnabled = "shorting_enabled";
  static const String _jsonKeyLongMarketValue = "long_market_value";
  static const String _jsonKeyShortMarketValue = "short_market_value";
  static const String _jsonKeyEquity = "equity";
  static const String _jsonKeyLastEquity = "last_equity";
  static const String _jsonKeyMultiplier = "multiplier";
  static const String _jsonKeyBuyingPower = "buying_power";
  static const String _jsonKeyInitialMargin = "initial_margin";
  static const String _jsonKeyMaintenanceMargin = "maintenance_margin";
  static const String _jsonKeySma = "sma";
  static const String _jsonKeyDaytradeCount = "daytrade_count";
  static const String _jsonKeyLastMaintenanceMargin = "last_maintenance_margin";
  static const String _jsonKeyDayTradingBuyingPower = "daytrading_buying_power";
  static const String _jsonKeyRegtBuyingPower = "regt_buying_power";

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
  static Account? fromMap(Map<String, dynamic> json) {
    try {
      String id = json[_jsonKeyId]!;
      String accountNumber = json[_jsonKeyAccountNumber]!;
      AccountStatus status = _toAccountStatus(json[_jsonKeyStatus]!);
      String currency = json[_jsonKeyCurrency]!;
      String cash = json[_jsonKeyCash]!;
      String portfolioValue = json[_jsonKeyPortfolioValue]!;
      bool patternDayTrader = json[_jsonKeyPatternDayTrader]!;
      bool tradeSuspendedByUser = json[_jsonKeyTradeSuspendedByUser]!;
      bool tradingBlocked = json[_jsonKeyTradingBlocked]!;
      bool transfersBlocked = json[_jsonKeyTransfersBlocked]!;
      bool accountBlocked = json[_jsonKeyAccountBlocked]!;
      DateTime createdAt = DateTime.parse(json[_jsonKeyCreatedAt]!);
      bool shortingEnabled = json[_jsonKeyShortingEnabled]!;
      String longMarketValue = json[_jsonKeyLongMarketValue]!;
      String shortMarketValue = json[_jsonKeyShortMarketValue]!;
      String equity = json[_jsonKeyEquity]!;
      String lastEquity = json[_jsonKeyLastEquity]!;
      String multiplier = json[_jsonKeyMultiplier]!;
      String buyingPower = json[_jsonKeyBuyingPower]!;
      String initialMargin = json[_jsonKeyInitialMargin]!;
      String maintenanceMargin = json[_jsonKeyMaintenanceMargin]!;
      String sma = json[_jsonKeySma]!;
      int daytradeCount = json[_jsonKeyDaytradeCount]!;
      String lastMaintenanceMargin = json[_jsonKeyLastMaintenanceMargin]!;
      String daytradingBuyingPower = json[_jsonKeyDayTradingBuyingPower]!;
      String regtBuyingPower = json[_jsonKeyRegtBuyingPower]!;
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
    Map<String, dynamic> json = {};
    json.putIfAbsent(_jsonKeyId, () => id);
    json.putIfAbsent(_jsonKeyAccountNumber, () => accountNumber);
    json.putIfAbsent(_jsonKeyStatus, () => _fromAccountStatus(status));
    json.putIfAbsent(_jsonKeyCurrency, () => currency);
    json.putIfAbsent(_jsonKeyCash, () => cash);
    json.putIfAbsent(_jsonKeyPortfolioValue, () => portfolioValue);
    json.putIfAbsent(_jsonKeyPatternDayTrader, () => patternDayTrader);
    json.putIfAbsent(_jsonKeyTradeSuspendedByUser, () => tradeSuspendedByUser);
    json.putIfAbsent(_jsonKeyTradingBlocked, () => tradingBlocked);
    json.putIfAbsent(_jsonKeyTransfersBlocked, () => transfersBlocked);
    json.putIfAbsent(_jsonKeyAccountBlocked, () => accountBlocked);
    json.putIfAbsent(_jsonKeyCreatedAt, () => createdAt.toUtc().toString());
    json.putIfAbsent(_jsonKeyShortingEnabled, () => shortingEnabled);
    json.putIfAbsent(_jsonKeyLongMarketValue, () => longMarketValue);
    json.putIfAbsent(_jsonKeyShortMarketValue, () => shortMarketValue);
    json.putIfAbsent(_jsonKeyEquity, () => equity);
    json.putIfAbsent(_jsonKeyLastEquity, () => lastEquity);
    json.putIfAbsent(_jsonKeyMultiplier, () => multiplier);
    json.putIfAbsent(_jsonKeyBuyingPower, () => buyingPower);
    json.putIfAbsent(_jsonKeyInitialMargin, () => initialMargin);
    json.putIfAbsent(_jsonKeyMaintenanceMargin, () => maintenanceMargin);
    json.putIfAbsent(_jsonKeySma, () => sma);
    json.putIfAbsent(_jsonKeyDaytradeCount, () => daytradeCount);
    json.putIfAbsent(
        _jsonKeyLastMaintenanceMargin, () => lastMaintenanceMargin);
    json.putIfAbsent(
        _jsonKeyDayTradingBuyingPower, () => daytradingBuyingPower);
    json.putIfAbsent(_jsonKeyRegtBuyingPower, () => regtBuyingPower);
    return json;
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
