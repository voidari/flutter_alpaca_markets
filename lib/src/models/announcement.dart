library alpaca_markets;

import 'package:alpaca_markets/src/settings.dart';

/// Public information on previous and upcoming dividends, mergers, spinoffs,
/// and stock splits.
class Announcement {
  static const String _keyId = "id";
  static const String _keyCorporateActionId = "corporate_action_id";
  static const String _keyCaType = "ca_type";
  static const String _keyCaSubType = "ca_sub_type";
  static const String _keyInitiatingSymbol = "initiating_symbol";
  static const String _keyInitiatingOriginalCusip = "initiating_original_cusip";
  static const String _keyTargetSymbol = "target_symbol";
  static const String _keyTargetOriginalCusip = "target_original_cusip";
  static const String _keyDeclarationDate = "declaration_date";
  static const String _keyEffectiveDate = "effective_date";
  static const String _keyExDate = "ex_date";
  static const String _keyRecordDate = "record_date";
  static const String _keyPayableDate = "payable_date";
  static const String _keyCash = "cash";
  static const String _keyOldRate = "old_rate";
  static const String _keyNewRate = "new_rate";

  /// ID that is specific to a single announcement.
  final String id;

  /// ID that remains consistent across all announcements for the same
  /// corporate action. Unlike ‘id’, this can be used to connect multiple
  /// announcements to see how the terms have changed throughout the lifecycle
  /// of the corporate action event.
  final String corporateActionId;

  /// 'dividend', 'merger', 'spinoff', or 'split'.
  final String caType;

  /// When ca_type = dividend, then cash or stock. When ca_type = merger, then
  /// merger_update or merger_completion. When ca_type = spinoff, then spinoff.
  /// When ca_type = split, then stock_split, unit_split, reverse_split, or
  /// recapitalization.
  final String caSubType;

  /// Symbol of the company initiating the announcement.
  final String? initiatingSymbol;

  /// CUSIP of the company initiating the announcement.
  final String? initiatingOriginalCusip;

  /// Symbol of the child company involved in the announcement.
  final String? targetSymbol;

  /// CUSIP of the child company involved in the announcement.
  final String? targetOriginalCusip;

  /// Date the corporate action or subsequent terms update was announced.
  final DateTime? declarationDate;

  /// The effective date of the announcement.
  final DateTime? effectiveDate;

  /// The first date that purchasing a security will not result in a corporate
  /// action entitlement.
  final DateTime? exDate;

  /// The date an account must hold a settled position in the security in order
  /// to receive the corporate action entitlement.
  final DateTime? recordDate;

  /// The date the announcement will take effect. On this date, account stock
  /// and cash balances are expected to be processed accordingly.
  final DateTime? payableDate;

  /// The amount of cash to be paid per share held by an account on the record
  /// date.
  final String cash;

  /// The denominator to determine any quantity change ratios in positions.
  final String oldRate;

  /// The numerator to determine any quantity change ratios in positions.
  final String newRate;

  /// The constructor of the announcement.
  Announcement(
      this.id,
      this.corporateActionId,
      this.caType,
      this.caSubType,
      this.initiatingSymbol,
      this.initiatingOriginalCusip,
      this.targetSymbol,
      this.targetOriginalCusip,
      this.declarationDate,
      this.effectiveDate,
      this.exDate,
      this.recordDate,
      this.payableDate,
      this.cash,
      this.oldRate,
      this.newRate);

  /// Constructs a announcement from the provided map.
  static Announcement? fromMap(Map<String, dynamic> map) {
    try {
      String id = map[_keyId];
      String corporateActionId = map[_keyCorporateActionId];
      String caType = map[_keyCaType];
      String caSubType = map[_keyCaSubType];
      String? initiatingSymbol = map[_keyInitiatingSymbol];
      String? initiatingOriginalCusip = map[_keyInitiatingOriginalCusip];
      String? targetSymbol = map[_keyTargetSymbol];
      String? targetOriginalCusip = map[_keyTargetOriginalCusip];
      DateTime? declarationDate = map[_keyDeclarationDate] != null
          ? DateTime.parse(map[_keyDeclarationDate])
          : null;
      DateTime? effectiveDate = map[_keyEffectiveDate] != null
          ? DateTime.parse(map[_keyEffectiveDate])
          : null;
      DateTime? exDate =
          map[_keyExDate] != null ? DateTime.parse(map[_keyExDate]) : null;
      DateTime? recordDate = map[_keyRecordDate] != null
          ? DateTime.parse(map[_keyRecordDate])
          : null;
      DateTime? payableDate = map[_keyPayableDate] != null
          ? DateTime.parse(map[_keyPayableDate])
          : null;
      String cash = map[_keyCash];
      String oldRate = map[_keyOldRate];
      String newRate = map[_keyNewRate];
      return Announcement(
          id,
          corporateActionId,
          caType,
          caSubType,
          initiatingSymbol,
          initiatingOriginalCusip,
          targetSymbol,
          targetOriginalCusip,
          declarationDate,
          effectiveDate,
          exDate,
          recordDate,
          payableDate,
          cash,
          oldRate,
          newRate);
    } catch (error) {
      if (Settings.debugPrint) {
        // ignore: avoid_print
        print(error);
      }
      return null;
    }
  }

  /// Creates a map given the current announcement data
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map.putIfAbsent(_keyId, () => id);
    map.putIfAbsent(_keyCorporateActionId, () => corporateActionId);
    map.putIfAbsent(_keyCaType, () => caType);
    map.putIfAbsent(_keyCaSubType, () => caSubType);
    map.putIfAbsent(_keyInitiatingSymbol, () => initiatingSymbol);
    map.putIfAbsent(_keyInitiatingOriginalCusip, () => initiatingOriginalCusip);
    map.putIfAbsent(_keyTargetSymbol, () => targetSymbol);
    map.putIfAbsent(_keyTargetOriginalCusip, () => targetOriginalCusip);
    if (declarationDate != null) {
      map.putIfAbsent(
          _keyDeclarationDate, () => declarationDate?.toUtc().toString());
    }
    if (effectiveDate != null) {
      map.putIfAbsent(
          _keyEffectiveDate, () => effectiveDate?.toUtc().toString());
    }
    if (exDate != null) {
      map.putIfAbsent(_keyExDate, () => exDate?.toUtc().toString());
    }
    if (recordDate != null) {
      map.putIfAbsent(_keyRecordDate, () => recordDate?.toUtc().toString());
    }
    if (payableDate != null) {
      map.putIfAbsent(_keyPayableDate, () => payableDate?.toUtc().toString());
    }
    map.putIfAbsent(_keyCash, () => cash);
    map.putIfAbsent(_keyOldRate, () => oldRate);
    map.putIfAbsent(_keyNewRate, () => newRate);
    return map;
  }
}
