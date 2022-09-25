library alpaca_markets;

import 'package:alpaca_markets/src/settings.dart';

/// provides custom configurations about your trading account settings.
/// These configurations control allow you to modify settings to suit your
/// trading needs.
class AccountConfigs {
  static const String _keyDtbpCheck = "dtbp_check";
  static const String _keyTradeConfirmEmail = "trade_confirm_email";
  static const String _keySuspendTrade = "suspend_trade";
  static const String _keyNoShorting = "no_shorting";
  static const String _keyFractionalTrading = "fractional_trading";
  static const String _keyMaxMarginMultiplier = "max_margin_multiplier";
  static const String _keyPdtCheck = "pdt_check";

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
  static AccountConfigs? fromMap(Map<String, dynamic> map) {
    try {
      String dtbpCheck = map[_keyDtbpCheck]!;
      String tradeConfirmEmail = map[_keyTradeConfirmEmail];
      bool suspendTrade = map[_keySuspendTrade];
      bool noShorting = map[_keyNoShorting];
      bool fractionalTrading = map[_keyFractionalTrading];
      String maxMarginMultiplier = map[_keyMaxMarginMultiplier];
      String pdtCheck = map[_keyPdtCheck];
      return AccountConfigs(dtbpCheck, tradeConfirmEmail, suspendTrade,
          noShorting, fractionalTrading, maxMarginMultiplier, pdtCheck);
    } catch (error) {
      if (Settings.debugPrint) {
        print(error);
      }
      return null;
    }
  }

  /// Creates a map given the current account configs data
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map.putIfAbsent(_keyDtbpCheck, () => dtbpCheck);
    map.putIfAbsent(_keyTradeConfirmEmail, () => tradeConfirmEmail);
    map.putIfAbsent(_keySuspendTrade, () => suspendTrade);
    map.putIfAbsent(_keyNoShorting, () => noShorting);
    map.putIfAbsent(_keyFractionalTrading, () => fractionalTrading);
    map.putIfAbsent(_keyMaxMarginMultiplier, () => maxMarginMultiplier);
    map.putIfAbsent(_keyPdtCheck, () => pdtCheck);
    return map;
  }
}
