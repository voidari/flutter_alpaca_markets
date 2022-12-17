// Copyright (C) 2022 by Voidari LLC or its subsidiaries.
library alpaca_markets;

import 'dart:convert';

import 'package:alpaca_markets/src/context.dart';
import 'package:http/http.dart' as http;

/// The class used to store all request information for
/// any type of request, and provides an easy way of building
/// a request.
class RequestBuilder {
  /// The base URL used for live trading
  static const String _baseUrl = "api.alpaca.markets";
  static const String _paperBaseUrl = "paper-api.alpaca.markets";

  /// Executes a GET request and provides the response.
  static Future<http.Response> get(Context context, String endpoint,
      {Map<String, dynamic>? params}) async {
    Uri url = Uri.https(_getUrl(context), endpoint, params);
    Map<String, String>? headers = _buildHeaders(context);
    return await http.get(url, headers: headers);
  }

  /// Executes a POST request and provides the response.
  static Future<http.Response> post(Context context, String endpoint,
      {Map<String, dynamic>? params, Object? body, Encoding? encoding}) async {
    Uri url = Uri.https(_getUrl(context), endpoint, params);
    Map<String, String>? headers = _buildHeaders(context);
    return await http.post(url,
        headers: headers, body: body, encoding: encoding);
  }

  /// Executes a DELETE request and provides the response.
  static Future<http.Response> delete(Context context, String endpoint,
      {Map<String, dynamic>? params, Object? body, Encoding? encoding}) async {
    Uri url = Uri.https(_getUrl(context), endpoint, params);
    Map<String, String>? headers = _buildHeaders(context);
    return await http.delete(url,
        headers: headers, body: body, encoding: encoding);
  }

  /// Executes a PUT request and provides the response.
  static Future<http.Response> put(Context context, String endpoint,
      {Map<String, dynamic>? params, Object? body, Encoding? encoding}) async {
    Uri url = Uri.https(_getUrl(context), endpoint, params);
    Map<String, String>? headers = _buildHeaders(context);
    return await http.put(url,
        headers: headers, body: body, encoding: encoding);
  }

  /// Executes a PATCH request and provides the response.
  static Future<http.Response> patch(Context context, String endpoint,
      {Map<String, dynamic>? params, Object? body, Encoding? encoding}) async {
    Uri url = Uri.https(_getUrl(context), endpoint, params);
    Map<String, String>? headers = _buildHeaders(context);
    return await http.patch(url,
        headers: headers, body: body, encoding: encoding);
  }

  /// Builds the default headers for every request.
  static Map<String, String>? _buildHeaders(Context context) {
    Map<String, String>? headers = {
      "APCA-API-KEY-ID": context.apcaApiKeyId,
      "APCA-API-SECRET-KEY": context.apcaApiSecretKey
    };
    return headers;
  }

  /// Retrieves the base URL that is to be used in the requst.
  static String _getUrl(Context context) {
    return context.isLive ? _baseUrl : _paperBaseUrl;
  }
}
