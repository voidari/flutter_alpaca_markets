library alpaca_markets;

import 'dart:convert';
import 'dart:io';

import 'package:alpaca_markets/src/models/announcement.dart';
import 'package:alpaca_markets/src/request_builder.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

/// The class used for retrieving corporate actions announcements related
/// content.
/// Announcement data is made available through the API as soon as it is
/// ingested by Alpaca, which is typically the following trading day after the
/// declaration date. This provides insight into future account stock position
/// and cash balance changes that will take effect on an announcement’s payable
/// date. Additionally, viewing previous announcement details can improve
/// bookkeeping and reconciling previous account cash and position changes.
class CorporateActionsAnnouncementsManager {
  /// Returns announcements data given specified search criteria.
  /// [caTypes] is a comma-delimited list of Dividend, Merger, Spinoff, or Split.
  /// The start (inclusive) of the date range, [since], when searching corporate
  /// action announcements.
  /// The end (inclusive) of the date range, [until], when
  /// searching corporate action announcements. The date range is limited to
  /// 90 days.
  /// The [symbol] of the company initiating the announcement.
  /// The [cusip] of the company initiating the announcement.
  /// The [dateType] is declaration_date, ex_date, record_date, or payable_date.
  static Future<List<Announcement>?> getAnnouncements(
      RequestBuilder requestBuilder,
      String caTypes,
      DateTime since,
      DateTime until,
      {String? symbol,
      String? cusip,
      String? dateType}) async {
    Map<String, dynamic> params = <String, dynamic>{};
    params.putIfAbsent("ca_types", () => caTypes);
    params.putIfAbsent("since", () => DateFormat("yyyy-MM-dd").format(since));
    params.putIfAbsent("until", () => DateFormat("yyyy-MM-dd").format(until));
    if (symbol != null) {
      params.putIfAbsent("symbol", () => symbol);
    }
    if (cusip != null) {
      params.putIfAbsent("cusip", () => cusip);
    }
    if (dateType != null) {
      params.putIfAbsent("date_type", () => dateType);
    }
    http.Response response = await requestBuilder
        .get("v2/corporate_actions/announcements", params: params);
    if (HttpStatus.ok != response.statusCode) {
      return null;
    }
    dynamic json = jsonDecode(response.body);
    List<Announcement> announcements = <Announcement>[];
    for (dynamic jsonAnnouncement in json) {
      Announcement? announcement = Announcement.fromMap(jsonAnnouncement);
      if (announcement != null) {
        announcements.add(announcement);
      }
    }
    return announcements;
  }

  /// Returns the announcement data matching the [announcementId] provided.
  static Future<Announcement?> getAnnouncement(
      RequestBuilder requestBuilder, String announcementId) async {
    http.Response response = await requestBuilder
        .get("v2/corporate_actions/announcements/$announcementId");
    if (HttpStatus.ok != response.statusCode) {
      return null;
    }
    dynamic json = jsonDecode(response.body);
    return Announcement.fromMap(json);
  }
}
