# Alpaca Markets

[![pub package](https://img.shields.io/pub/v/alpaca_markets.svg)](https://pub.dev/packages/alpaca_markets)

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

## Introduction

A wrapper for the Alpaca Markets trading APIs. Provides an easy dart-specific way of working with the broker, trading, and market data requests.

For information on Alpaca Markets and their APIs, see the documentation on [Alpaca Market's Overview](https://alpaca.markets/docs/introduction/).

## Prerequisites

The APIs require that you signup as either a trader or a broker, depending on the type of app you are developing. Visit [https://alpaca.markets/](https://alpaca.markets/) to sign up.

## Usage
To use this plugin, add `alpaca_markets` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

### Examples

Here are small examples that show you how to use the API. The examples provided do not show all return values, parameters, and even functions that are available. Please review the documentation for additional information.

#### Create a context

Use your generated live and/or paper keys to create a context for querying.

```dart
import 'package:alpaca_markets/alpaca_markets.dart' as alpaca;

alpaca.Context liveContext = alpaca.createLiveContext(
        "<Insert live key>", "<Insert live secret key>");

alpaca.Context paperContext = alpaca.createPaperContext(
        "<Insert paper key>", "<Insert paper secret key>");
```

#### Retrieve and update account info and assets

The [Account](https://github.com/voidari/flutter/blob/main/alpaca_markets/lib/src/account.dart) and [AccountConfigs](https://github.com/voidari/flutter/blob/main/alpaca_markets/lib/src/account_configs.dart) classes are available for viewing the fields of data.

```dart
alpaca.Account? account = await alpaca.getAccount();
alpaca.AccountConfigs? configs = await alpaca.getAccountConfigs();
await alpaca.updateAccountConfigs(tradeConfirmEmail: "none");
```

#### Asset retrieval

Additional parameters for the getAssets() request include asset status, asset class, and exchange filters.

The [Asset](https://github.com/voidari/flutter/blob/main/alpaca_markets/lib/src/asset.dart) class is available for viewing the fields of data.

```dart
alpaca.Asset? asset = await alpaca.getAsset("GRMN");
List<alpaca.Asset>? assets = await alpaca.getAssets();
```

#### Portfolio operations

Additional parameters for the getPortfolioHistory() request can be found in the documentation.

The [PortfolioHistory](https://github.com/voidari/flutter/blob/main/alpaca_markets/lib/src/portfolio_history.dart) class is available for viewing the fields of data.

```dart
alpaca.PortfolioHistory? portfolioHistory = await alpaca.getPortfolioHistory();
```

#### Add, edit, and delete watchlists

A watchlist can be added to an Alpaca account through their web portal, but the APIs can provide multiple watchlists and support them all using the following example.

```dart
// Create a watchlist
alpaca.Watchlist? watchlist = await alpaca.createWatchlist("My Watchlist", symbols: ["AAPL", "GOOG"]);
// Get the watchlists
List<alpaca.Watchlist>? watchlists = await alpaca.getWatchlists(withAssets: false);
watchlist = await alpaca.getWatchlist(watchlist?.id);
// Update the watchlist name and symbols
await alpaca.updateWatchlist(watchlist?.id, name: "My Watchlist Plus", symbols: ["GRMN", "TSLA"]);
// Add a new symbol
await alpaca.addWatchlistSymbol(watchlist?.id, "GME");
// Delete the symbol
await alpaca.deleteWatchlistSymbol(watchlist?.id, "GME");
// Delete the watchlist
await alpaca.deleteWatchlist(watchlist?.id);
// Delete all watchlists
await alpaca.deleteAllWatchlists();
```

#### Calendar and market clock

The calendar API provides a way to request a range of dates that the market is open for, with the date, open, and close timestamps.
The market clock is the current time, whether the market is open, when the market opens next, and when the market closes next.

```dart
/// Retrieve a specific date
alpaca.Calendar? calendar = await alpaca.getCalendarDate(const DateTime(2022, 11, 1));
/// Retrieves a range of dates
List<alpaca.Calendar>? calendars = await alpaca.getCalendarDates(
    start: const DateTime(2022, 10, 25), end: const DateTime(2022, 10, 31));
/// Retrieve the market clock
alpaca.Clock? clock = await alpaca.getMarketClock();
```

#### Announcements

Additional parameters for the getAnnouncements().

The [Announcement](https://github.com/voidari/flutter/blob/main/alpaca_markets/lib/src/announcement.dart) class is available for viewing the fields of data.

```dart
List<alpaca.Announcement>? announcements = await alpaca.getAnnouncements("Dividend",
        DateTime.now().subtract(const Duration(days: 75)), DateTime.now());
alpaca.Announcement? announcement = await alpaca.getAnnouncement(id);
```

## Appreciation and Proposals

When we work on a project, any internal library we create that could benefit the community will be made public for free use. Please consider contributing, as work does go into creating and maintaining this library. As always, if something could be improved, please create an issue for it in the project repo and we'll be happy to discuss!

[<img src="img/buymecoffee.png" width="175"/>](https://www.buymeacoffee.com/voidari)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/voidari/flutter_alpaca_markets.svg?style=for-the-badge
[contributors-url]: https://github.com/voidari/flutter_alpaca_markets/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/voidari/flutter_alpaca_markets.svg?style=for-the-badge
[forks-url]: https://github.com/voidari/flutter_alpaca_markets/network/members
[stars-shield]: https://img.shields.io/github/stars/voidari/flutter_alpaca_markets.svg?style=for-the-badge
[stars-url]: https://github.com/voidari/flutter_alpaca_markets/stargazers
[issues-shield]: https://img.shields.io/github/issues/voidari/flutter_alpaca_markets.svg?style=for-the-badge
[issues-url]: https://github.com/voidari/flutter_alpaca_markets/issues
[license-shield]: https://img.shields.io/github/license/voidari/flutter_alpaca_markets.svg?style=for-the-badge
[license-url]: https://github.com/voidari/flutter_alpaca_markets/blob/main/LICENSE