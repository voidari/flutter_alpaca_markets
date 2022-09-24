library alpaca_markets;

import 'dart:convert';

import 'package:http/http.dart' as http;

/// The credentials keys container
class Credentials {
  /// The client's API key for requests
  String apcaApiKeyId;

  /// The client's API secret key for requests
  String apcaApiSecretKey;

  /// The constructor
  Credentials(this.apcaApiKeyId, this.apcaApiSecretKey);
}

/// The class used to store all request information for
/// any type of request, and provides an easy way of building
/// a request.
class RequestBuilder {
  /// The base URL used for live trading
  static const String _baseUrl = "api.alpaca.markets";
  static const String _paperBaseUrl = "paper-api.alpaca.markets";

  /// The client's API key for requests
  Credentials? _liveCredentials;

  /// The client's API secret key for requests
  Credentials? _paperCredentials;

  /// Determines if live or paper trading is selected
  bool _isLive = true;

  /// The constructor used to set the API keys.
  RequestBuilder(this._liveCredentials, this._paperCredentials);

  /// Provides a means to update the credentials for either live or
  /// paper trading platforms.
  void updateCredentials(Credentials credentials, {bool isLive = true}) {
    if (isLive) {
      _liveCredentials = credentials;
    } else {
      _paperCredentials = credentials;
    }
  }

  /// Enable live trading for real world transaction requests.
  void enableLiveTrading() {
    _isLive = true;
  }

  /// Enable paper trading to avoid real transaction requests.
  void enablePaperTrading() {
    _isLive = false;
  }

  /// Executes a GET request and provides the response.
  Future<http.Response> get(String endpoint,
      {Map<String, dynamic>? params}) async {
    Uri url = Uri.https(_getUrl(), endpoint, params);
    Map<String, String>? headers = buildHeaders();
    return await http.get(url, headers: headers);
  }

  /// Executes a POST request and provides the response.
  Future<http.Response> post(String endpoint,
      {Map<String, dynamic>? params, Object? body, Encoding? encoding}) async {
    Uri url = Uri.https(_getUrl(), endpoint, params);
    Map<String, String>? headers = buildHeaders();
    return await http.post(url,
        headers: headers, body: body, encoding: encoding);
  }

  /// Executes a DELETE request and provides the response.
  Future<http.Response> delete(String endpoint,
      {Map<String, dynamic>? params, Object? body, Encoding? encoding}) async {
    Uri url = Uri.https(_getUrl(), endpoint, params);
    Map<String, String>? headers = buildHeaders();
    return await http.delete(url,
        headers: headers, body: body, encoding: encoding);
  }

  /// Executes a PUT request and provides the response.
  Future<http.Response> put(String endpoint,
      {Map<String, dynamic>? params, Object? body, Encoding? encoding}) async {
    Uri url = Uri.https(_getUrl(), endpoint, params);
    Map<String, String>? headers = buildHeaders();
    return await http.put(url,
        headers: headers, body: body, encoding: encoding);
  }

  /// Executes a PATCH request and provides the response.
  Future<http.Response> patch(String endpoint,
      {Map<String, dynamic>? params, Object? body, Encoding? encoding}) async {
    Uri url = Uri.https(_getUrl(), endpoint, params);
    Map<String, String>? headers = buildHeaders();
    return await http.patch(url,
        headers: headers, body: body, encoding: encoding);
  }

  /// Builds the default headers for every request.
  Map<String, String>? buildHeaders() {
    Map<String, String>? headers = {
      "APCA-API-KEY-ID": _getCredentials().apcaApiKeyId,
      "APCA-API-SECRET-KEY": _getCredentials().apcaApiSecretKey
    };
    return headers;
  }

  /// Gets the correct credentials depending on the selected live setting.
  Credentials _getCredentials() {
    Credentials? credentials = _isLive ? _liveCredentials : _paperCredentials;
    if (credentials == null) {
      throw Exception(
          "Attempted to request ${_isLive ? "live trading" : "paper trading"} data without credentials for it.");
    }
    return credentials;
  }

  /// Retrieves the base URL that is to be used in the requst.
  String _getUrl() {
    return _isLive ? _baseUrl : _paperBaseUrl;
  }
}
