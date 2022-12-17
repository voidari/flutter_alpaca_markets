// Copyright (C) 2022 by Voidari LLC or its subsidiaries.
library alpaca_markets;

import 'package:alpaca_markets/src/settings.dart';

/// Represents information about a market position.
class Position {
  static const String _keyAssetId = "asset_id";
  static const String _keySymbol = "symbol";
  static const String _keyExchange = "exchange";
  static const String _keyAssetClass = "asset_class";
  static const String _keyAvgEntryPrice = "avg_entry_price";
  static const String _keyQty = "qty";
  static const String _keyQtyAvailable = "qty_available";
  static const String _keySide = "side";
  static const String _keyMarketValue = "market_value";
  static const String _keyCostBasis = "cost_basis";
  static const String _keyUnrealizedPl = "unrealized_pl";
  static const String _keyUnrealizedPlpc = "unrealized_plpc";
  static const String _keyUnrealizedIntradayPl = "unrealized_intraday_pl";
  static const String _keyUnrealizedIntradayPlpc = "unrealized_intraday_plpc";
  static const String _keyCurrentPrice = "current_price";
  static const String _keyLastdayPrice = "lastday_price";
  static const String _keyChangeToday = "change_today";

  /// The asset UUID.
  final String assetId;

  /// Symbol name of the asset.
  final String symbol;

  /// Exchange name of the asset (ErisX for crypto).
  final String exchange;

  /// Asset class name.
  final String assetClass;

  /// Average entry price of the position.
  final String averageEntryPrice;

  /// The number of shares.
  final int quantity;

  /// Total number of shares available minus open orders.
  final int quantityAvailable;

  /// “long”.
  final String side;

  /// Total dollar amount of the position.
  /// This value is a number.
  final String marketValue;

  /// Total cost basis in dollar.
  /// This value is a number.
  final String costBasis;

  /// Unrealized profit/loss in dollars.
  /// This value is a number.
  final String unrealizedProfitLoss;

  /// Unrealized profit/loss percent (by a factor of 1).
  /// This value is a number.
  final String unrealizedProfitLossPercent;

  /// Unrealized profit/loss in dollars for the day.
  /// This value is a number.
  final String unrealizedIntradayProfitLoss;

  /// Unrealized profit/loss percent (by a factor of 1).
  /// This value is a number.
  final String unrealizedIntradayProfitLossPercent;

  /// Current asset price per share.
  /// This value is a number.
  final String currentPrice;

  /// Last day’s asset price per share based on the closing value of the last
  /// trading day.
  /// This value is a number.
  final String lastdayPrice;

  /// Percent change from last day price (by a factor of 1).
  /// This value is a number.
  final String changeToday;

  /// The constructor of the position.
  Position(
      this.assetId,
      this.symbol,
      this.exchange,
      this.assetClass,
      this.averageEntryPrice,
      this.quantity,
      this.quantityAvailable,
      this.side,
      this.marketValue,
      this.costBasis,
      this.unrealizedProfitLoss,
      this.unrealizedProfitLossPercent,
      this.unrealizedIntradayProfitLoss,
      this.unrealizedIntradayProfitLossPercent,
      this.currentPrice,
      this.lastdayPrice,
      this.changeToday);

  /// Constructs a position from the provided map.
  static Position? fromMap(Map<String, dynamic> map) {
    try {
      final String assetId = map[_keyAssetId];
      final String symbol = map[_keySymbol];
      final String exchange = map[_keyExchange];
      final String assetClass = map[_keyAssetClass];
      final String averageEntryPrice = map[_keyAvgEntryPrice];
      final int quantity = map[_keyQty];
      final int quantityAvailable = map[_keyQtyAvailable];
      final String side = map[_keySide];
      final String marketValue = map[_keyMarketValue];
      final String costBasis = map[_keyCostBasis];
      final String unrealizedProfitLoss = map[_keyUnrealizedPl];
      final String unrealizedProfitLossPercent = map[_keyUnrealizedPlpc];
      final String unrealizedIntradayProfitLoss = map[_keyUnrealizedIntradayPl];
      final String unrealizedIntradayProfitLossPercent =
          map[_keyUnrealizedIntradayPlpc];
      final String currentPrice = map[_keyCurrentPrice];
      final String lastdayPrice = map[_keyLastdayPrice];
      final String changeToday = map[_keyChangeToday];
      return Position(
          assetId,
          symbol,
          exchange,
          assetClass,
          averageEntryPrice,
          quantity,
          quantityAvailable,
          side,
          marketValue,
          costBasis,
          unrealizedProfitLoss,
          unrealizedProfitLossPercent,
          unrealizedIntradayProfitLoss,
          unrealizedIntradayProfitLossPercent,
          currentPrice,
          lastdayPrice,
          changeToday);
    } catch (error) {
      if (Settings.debugPrint) {
        // ignore: avoid_print
        print(error);
      }
      return null;
    }
  }

  /// Creates a map given the current position data
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _keyAssetId: assetId,
      _keySymbol: symbol,
      _keyExchange: exchange,
      _keyAssetClass: assetClass,
      _keyAvgEntryPrice: averageEntryPrice,
      _keyQty: quantity,
      _keyQtyAvailable: quantityAvailable,
      _keySide: side,
      _keyMarketValue: marketValue,
      _keyCostBasis: costBasis,
      _keyUnrealizedPl: unrealizedProfitLoss,
      _keyUnrealizedPlpc: unrealizedProfitLossPercent,
      _keyUnrealizedIntradayPl: unrealizedIntradayProfitLoss,
      _keyUnrealizedIntradayPlpc: unrealizedIntradayProfitLossPercent,
      _keyCurrentPrice: currentPrice,
      _keyLastdayPrice: lastdayPrice,
      _keyChangeToday: changeToday
    };
  }
}
