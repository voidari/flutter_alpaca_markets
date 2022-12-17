// Copyright (C) 2022 by Voidari LLC or its subsidiaries.
library alpaca_markets;

import 'package:alpaca_markets/src/settings.dart';

/// The asset object used to hold both equity and crypto
/// asset data returned from the asset requests.
class Asset {
  static const String _keyId = "id";
  static const String _keyClass = "class";
  static const String _keyExchange = "exchange";
  static const String _keySymbol = "symbol";
  static const String _keyName = "name";
  static const String _keyStatus = "status";
  static const String _keyTradable = "tradable";
  static const String _keyMarginable = "marginable";
  static const String _keyShortable = "shortable";
  static const String _keyEasyToBorrow = "easy_to_borrow";
  static const String _keyFractionable = "fractionable";
  static const String _keyMinOrderSize = "min_order_size";
  static const String _keyMinTradeIncrement = "min_trade_increment";
  static const String _keyPriceIncrement = "price_increment";
  static const String _keyMaintenanceMarginRequirement =
      "maintenance_margin_requirement";

  /// Asset ID.
  final String id;

  /// The type of asset, ex: 'crypto'
  final String assetClass;

  /// The name of the exchange, ex: 'FTXU'
  final String exchange;

  /// Symbol of asset
  final String symbol;

  /// The name of the asset
  final String name;

  /// 'active' or 'inactive'
  final String status;

  /// Asset is tradable on Alpaca or not.
  final bool tradable;

  /// Asset is marginable or not.
  final bool marginable;

  /// Asset is shortable or not.
  final bool shortable;

  /// Asset is easy-to-borrow or not.
  final bool easyToBorrow;

  /// Asset is fractionable or not.
  final bool fractionable;

  /// Minimum order size. Field available for crypto only.
  /// This value is a number.
  final String? minOrderSize;

  /// Amount a trade quantity can be incremented by. Field available
  /// for crypto only.
  /// This value is a number.
  final String? minTradeIncrement;

  /// Amount the price can be incremented by. Field available for crypto only.
  /// This value is a number.
  final String? priceIncrement;

  /// Shows the % margin requirement for the asset (equities only).
  final int? maintenanceMarginRequirement;

  /// The constructor of the asset
  Asset(
      this.id,
      this.assetClass,
      this.exchange,
      this.symbol,
      this.name,
      this.status,
      this.tradable,
      this.marginable,
      this.shortable,
      this.easyToBorrow,
      this.fractionable,
      this.minOrderSize,
      this.minTradeIncrement,
      this.priceIncrement,
      this.maintenanceMarginRequirement);

  /// Utility used to get the boolean active status.
  bool isActive() {
    return status == "active";
  }

  /// Constructs an asset from the provided map.
  static Asset? fromMap(Map<String, dynamic> map) {
    try {
      // Parse the ID
      if (!map.containsKey(_keyId)) {
        return null;
      }
      String id = map[_keyId]!;
      // Parse the class
      if (!map.containsKey(_keyClass)) {
        return null;
      }
      String assetClass = map[_keyClass];
      // Parse the exchange
      if (!map.containsKey(_keyExchange)) {
        return null;
      }
      String exchange = map[_keyExchange];
      // Parse the symbol
      if (!map.containsKey(_keySymbol)) {
        return null;
      }
      String symbol = map[_keySymbol];
      // Parse the name
      String name = "";
      if (map.containsKey(_keyName)) {
        name = map[_keyName];
      }
      // Parse the status
      String status = "";
      if (map.containsKey(_keyStatus)) {
        status = map[_keyStatus];
      }
      // Parse the tradable
      bool tradable = false;
      if (map.containsKey(_keyTradable)) {
        tradable = map[_keyTradable];
      }
      // Parse the marginable
      bool marginable = false;
      if (map.containsKey(_keyMarginable)) {
        marginable = map[_keyMarginable];
      }
      // Parse the shortable
      bool shortable = false;
      if (map.containsKey(_keyShortable)) {
        shortable = map[_keyShortable];
      }
      // Parse the easyToBorrow
      bool easyToBorrow = false;
      if (map.containsKey(_keyEasyToBorrow)) {
        easyToBorrow = map[_keyEasyToBorrow];
      }
      // Parse the tradable
      bool fractionable = false;
      if (map.containsKey(_keyFractionable)) {
        fractionable = map[_keyFractionable];
      }
      // Parse the minOrderSize
      String? minOrderSize;
      if (map.containsKey(_keyMinOrderSize)) {
        minOrderSize = map[_keyMinOrderSize];
      }
      // Parse the minTradeIncrement
      String? minTradeIncrement;
      if (map.containsKey(_keyMinTradeIncrement)) {
        minTradeIncrement = map[_keyMinTradeIncrement];
      }
      // Parse the priceIncrement
      String? priceIncrement;
      if (map.containsKey(_keyPriceIncrement)) {
        priceIncrement = map[_keyPriceIncrement];
      }
      // Parse the status
      int? maintenanceMarginRequirement;
      if (map.containsKey(_keyMaintenanceMarginRequirement)) {
        maintenanceMarginRequirement = map[_keyMaintenanceMarginRequirement];
      }
      // Create the asset
      return Asset(
          id,
          assetClass,
          exchange,
          symbol,
          name,
          status,
          tradable,
          marginable,
          shortable,
          easyToBorrow,
          fractionable,
          minOrderSize,
          minTradeIncrement,
          priceIncrement,
          maintenanceMarginRequirement);
    } catch (error) {
      if (Settings.debugPrint) {
        // ignore: avoid_print
        print(error);
      }
      return null;
    }
  }

  /// Creates a map given the current asset data
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map.putIfAbsent(_keyId, () => id);
    map.putIfAbsent(_keyClass, () => assetClass);
    map.putIfAbsent(_keyExchange, () => exchange);
    map.putIfAbsent(_keySymbol, () => symbol);
    if (name.isNotEmpty) {
      map.putIfAbsent(_keyName, () => name);
    }
    if (status.isNotEmpty) {
      map.putIfAbsent(_keyStatus, () => status);
    }
    map.putIfAbsent(_keyTradable, () => tradable);
    map.putIfAbsent(_keyMarginable, () => marginable);
    map.putIfAbsent(_keyShortable, () => shortable);
    map.putIfAbsent(_keyEasyToBorrow, () => easyToBorrow);
    map.putIfAbsent(_keyFractionable, () => fractionable);
    if (minOrderSize != null) {
      map.putIfAbsent(_keyMinOrderSize, () => minOrderSize);
    }
    if (minTradeIncrement != null) {
      map.putIfAbsent(_keyMinTradeIncrement, () => minTradeIncrement);
    }
    if (priceIncrement != null) {
      map.putIfAbsent(_keyPriceIncrement, () => priceIncrement);
    }
    if (maintenanceMarginRequirement != null) {
      map.putIfAbsent(
          _keyMaintenanceMarginRequirement, () => maintenanceMarginRequirement);
    }
    return map;
  }
}
