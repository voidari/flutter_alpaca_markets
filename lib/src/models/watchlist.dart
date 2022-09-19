library alpaca_markets;

import 'package:alpaca_markets/src/models/asset.dart';

/// Each watchlist is an ordered list of assets, accessed by the
/// name or ID of the entitiy.
class Watchlist {
  static const String _jsonKeyId = "id";
  static const String _jsonKeyCreatedAt = "created_at";
  static const String _jsonKeyUpdatedAt = "updated_at";
  static const String _jsonKeyName = "name";
  static const String _jsonKeyAccountId = "account_id";
  static const String _jsonKeyAssets = "assets";

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
  static Watchlist? fromMap(Map<String, dynamic> json) {
    try {
      String id = json[_jsonKeyId]!;
      DateTime createdAt = DateTime.parse(json[_jsonKeyCreatedAt]!);
      DateTime updatedAt = DateTime.parse(json[_jsonKeyUpdatedAt]!);
      String name = json[_jsonKeyName]!;
      String accountId = json[_jsonKeyAccountId]!;
      List<Asset> assets = <Asset>[];
      if (json.containsKey(_jsonKeyAssets)) {
        for (dynamic jsonAsset in json[_jsonKeyAssets]) {
          Asset? asset = Asset.fromMap(jsonAsset);
          if (asset != null) {
            assets.add(asset);
          }
        }
      }
      return Watchlist(id, createdAt, updatedAt, name, accountId, assets);
    } catch (error) {
      return null;
    }
  }

  /// Creates a map given the current watchlist data
  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {};
    json.putIfAbsent(_jsonKeyId, () => id);
    json.putIfAbsent(_jsonKeyCreatedAt, () => createdAt.toUtc().toString());
    json.putIfAbsent(_jsonKeyUpdatedAt, () => updatedAt.toUtc().toString());
    json.putIfAbsent(_jsonKeyName, () => name);
    json.putIfAbsent(_jsonKeyAccountId, () => accountId);
    if (assets.isNotEmpty) {
      List<dynamic> assetList = <dynamic>[];
      for (Asset asset in assets) {
        assetList.add(asset.toMap());
      }
      json.putIfAbsent(_jsonKeyAssets, () => assetList);
    }
    return json;
  }
}
