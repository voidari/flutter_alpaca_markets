// Copyright (C) 2022 by Voidari LLC or its subsidiaries.
library alpaca_markets;

import 'package:alpaca_markets/src/models/asset.dart';
import 'package:alpaca_markets/src/settings.dart';

/// Each watchlist is an ordered list of assets, accessed by the
/// name or ID of the entitiy.
class Watchlist {
  static const String _keyId = "id";
  static const String _keyCreatedAt = "created_at";
  static const String _keyUpdatedAt = "updated_at";
  static const String _keyName = "name";
  static const String _keyAccountId = "account_id";
  static const String _keyAssets = "assets";

  /// Watchlist ID
  final String id;

  /// The timestamp for when the watchlist was created.
  final DateTime createdAt;

  /// The timestamp for when the watchlist was last updated.
  final DateTime updatedAt;

  /// The user-defined watchlist name (up to 64 characters).
  final String name;

  /// Account ID
  final String accountId;

  /// The content of this watchlist, in the order as registered by the client.
  final List<Asset> assets;

  /// The constructor of the watchlist
  Watchlist(this.id, this.createdAt, this.updatedAt, this.name, this.accountId,
      this.assets);

  /// Constructs a watchlist from the provided map.
  static Watchlist? fromMap(Map<String, dynamic> map) {
    try {
      String id = map[_keyId];
      DateTime createdAt = DateTime.parse(map[_keyCreatedAt]);
      DateTime updatedAt = DateTime.parse(map[_keyUpdatedAt]);
      String name = map[_keyName];
      String accountId = map[_keyAccountId];
      List<Asset> assets = <Asset>[];
      if (map.containsKey(_keyAssets)) {
        for (dynamic mapAsset in map[_keyAssets]) {
          Asset? asset = Asset.fromMap(mapAsset);
          if (asset != null) {
            assets.add(asset);
          }
        }
      }
      return Watchlist(id, createdAt, updatedAt, name, accountId, assets);
    } catch (error) {
      if (Settings.debugPrint) {
        // ignore: avoid_print
        print(error);
      }
      return null;
    }
  }

  /// Creates a map given the current watchlist data
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map.putIfAbsent(_keyId, () => id);
    map.putIfAbsent(_keyCreatedAt, () => createdAt.toUtc().toString());
    map.putIfAbsent(_keyUpdatedAt, () => updatedAt.toUtc().toString());
    map.putIfAbsent(_keyName, () => name);
    map.putIfAbsent(_keyAccountId, () => accountId);
    if (assets.isNotEmpty) {
      List<dynamic> assetList = <dynamic>[];
      for (Asset asset in assets) {
        assetList.add(asset.toMap());
      }
      map.putIfAbsent(_keyAssets, () => assetList);
    }
    return map;
  }
}
