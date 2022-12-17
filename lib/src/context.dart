// Copyright (C) 2022 by Voidari LLC or its subsidiaries.
library alpaca_markets;

/// The credentials keys container
class Context {
  static const String _apcaApiKeyIdKey = "apca_api_key_id";
  static const String _apcaApiSecretKeyKey = "apca_api_secret_key";
  static const String _isLiveKey = "is_live";

  /// The client's API key for requests
  String apcaApiKeyId;

  /// The client's API secret key for requests
  String apcaApiSecretKey;

  /// Determines if the credentials are live or paper
  bool isLive;

  /// The constructor
  Context(this.apcaApiKeyId, this.apcaApiSecretKey, this.isLive);

  /// Converts the context into a map.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      _apcaApiKeyIdKey: apcaApiKeyId,
      _apcaApiSecretKeyKey: apcaApiSecretKey,
      _isLiveKey: isLive
    };
  }

  /// Converts the map into a context.
  Context fromMap(Map<String, dynamic> map) {
    return Context(
        map[_apcaApiKeyIdKey], map[apcaApiSecretKey], map[_isLiveKey]);
  }
}
