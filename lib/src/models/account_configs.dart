library alpaca_markets;

/// provides custom configurations about your trading account settings.
/// These configurations control allow you to modify settings to suit your
/// trading needs.
class AccountConfigs {
  static const String _jsonKeyDtbpCheck = "dtbp_check";
  static const String _jsonKeyTradeConfirmEmail = "trade_confirm_email";
  static const String _jsonKeySuspendTrade = "suspend_trade";
  static const String _jsonKeyNoShorting = "no_shorting";
  static const String _jsonKeyFractionalTrading = "fractional_trading";
  static const String _jsonKeyMaxMarginMultiplier = "max_margin_multiplier";
  static const String _jsonKeyPdtCheck = "pdt_check";

  /// 'both', 'entry', or 'exit'.
  /// Controls Day Trading Margin Call (DTMC) checks.
  final String dtbpCheck;

  /// 'all' or 'none'.
  /// If 'none', emails for order fills are not sent.
  /// Other non-trade emails are unaffected.
  final String tradeConfirmEmail;

  /// If true, new orders are blocked.
  final bool suspendTrade;

  /// If true, account becomes long-only mode.
  final bool noShorting;

  /// If true, account is able to place fractional trades.
  final bool fractionalTrading;

  // 1 or 2. If 1, account is limited to no margin (limited margin only).
  //A value of 2 provides 2x RegT margin and allows 4x Day intraday margin,
  //if applicable.
  final String maxMarginMultiplier;

  /// 'both', 'entry', or 'exit'.
  /// Controls [Pattern Day Trading
  /// (PDT)]{#pattern-day-trader-pdt-protection-at-alpaca} checks.
  /// If entry orders will be rejected on entering a position if it could
  /// result in PDT being set for the account. exit will reject exiting orders
  /// if they would result in PDT being set.
  final String pdtCheck;

  /// The constructor of the account configs.
  AccountConfigs(
      this.dtbpCheck,
      this.tradeConfirmEmail,
      this.suspendTrade,
      this.noShorting,
      this.fractionalTrading,
      this.maxMarginMultiplier,
      this.pdtCheck);

  /// Constructs an account configs from the provided map.
  static AccountConfigs? fromMap(Map<String, dynamic> json) {
    try {
      String dtbpCheck = json[_jsonKeyDtbpCheck]!;
      String tradeConfirmEmail = json[_jsonKeyTradeConfirmEmail];
      bool suspendTrade = json[_jsonKeySuspendTrade];
      bool noShorting = json[_jsonKeyNoShorting];
      bool fractionalTrading = json[_jsonKeyFractionalTrading];
      String maxMarginMultiplier = json[_jsonKeyMaxMarginMultiplier];
      String pdtCheck = json[_jsonKeyPdtCheck];
      return AccountConfigs(dtbpCheck, tradeConfirmEmail, suspendTrade,
          noShorting, fractionalTrading, maxMarginMultiplier, pdtCheck);
    } catch (error) {
      return null;
    }
  }

  /// Creates a map given the current account configs data
  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {};
    json.putIfAbsent(_jsonKeyDtbpCheck, () => dtbpCheck);
    json.putIfAbsent(_jsonKeyTradeConfirmEmail, () => tradeConfirmEmail);
    json.putIfAbsent(_jsonKeySuspendTrade, () => suspendTrade);
    json.putIfAbsent(_jsonKeyNoShorting, () => noShorting);
    json.putIfAbsent(_jsonKeyFractionalTrading, () => fractionalTrading);
    json.putIfAbsent(_jsonKeyMaxMarginMultiplier, () => maxMarginMultiplier);
    json.putIfAbsent(_jsonKeyPdtCheck, () => pdtCheck);
    return json;
  }
}
