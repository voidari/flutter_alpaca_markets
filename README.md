# Alpaca Markets

[![pub package](https://img.shields.io/pub/v/alpaca_markets.svg)](https://pub.dev/packages/alpaca_markets)
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

A wrapper for the Alpaca Markets trading APIs. Provides an easy dart-specific way of working with the broker, trading, and market data requests.

For information on Alpaca Markets and their APIs, see the documentation on [Alpaca Market's Overview](https://alpaca.markets/docs/introduction/).

## Prerequisites

The APIs require that you signup as either a trader or a broker, depending on the type of app you are developing. Visit [https://alpaca.markets/](https://alpaca.markets/) to sign up.

## Usage
To use this plugin, add `alpaca_markets` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

### Examples

Here are small examples that show you how to use the API. The examples provided do not show all return values, parameters, and even functions that are available. Please review the documentation for additonal information.

#### Create an instance

Use your generated live and/or paper keys to create an instance for querying.

```dart
AlpacaMarkets am = AlpacaMarkets(
        liveApacApiKeyId: "<Insert live key>",
        liveApcaApiSecretKey: "<Insert secret live key>",
        paperApacApiKeyId: "<Insert paper key>",
        paperApcaApiSecretKey: "<Insert secret paper key>");
```

#### Retrieve and update account info and assets

The [Account](https://github.com/voidari/flutter/blob/main/alpaca_markets/lib/src/account.dart) and [AccountConfigs](https://github.com/voidari/flutter/blob/main/alpaca_markets/lib/src/account_configs.dart) classes are available for viewing the fields of data.

```dart
Account? account = await am.getAccount();
AccountConfigs? configs = await am.getAccountConfigs();
await am.updateAccountConfigs(tradeConfirmEmail: "none");
```

#### Asset retrieval

Additional parameters for the getAssets() request include asset status, asset class, and exchange filters.

The [Asset](https://github.com/voidari/flutter/blob/main/alpaca_markets/lib/src/asset.dart) class is available for viewing the fields of data.

```dart
Asset? asset = await am.getAsset("GRMN");
List<Asset>? assets = await am.getAssets();
```

#### Portfolio operations

Additional parameters for the getPortfolioHistory() request can be found in the documentation.

The [PortfolioHistory](https://github.com/voidari/flutter/blob/main/alpaca_markets/lib/src/portfolio_history.dart) class is available for viewing the fields of data.

```dart
PortfolioHistory? portfolioHistory = await am.getPortfolioHistory();
```

#### Add, edit, and delete watchlists

A watchlist can be added to an Alpaca account through their web portal, but the APIs can provide multiple watchlists and support them all using the following example.

```dart
// Create a watchlist
Watchlist? watchlist = await am.createWatchlist("My Watchlist", symbols: ["AAPL", "GOOG"]);
// Get the watchlists
List<Watchlist>? watchlists = await am.getWatchlists(withAssets: false);
watchlist = await am.getWatchlist(watchlist?.id);
// Update the watchlist name and symbols
await am.updateWatchlist(watchlist?.id, name: "My Watchlist Plus", symbols: ["GRMN", "TSLA"]);
// Add a new symbol
await am.addWatchlistSymbol(watchlist?.id, "GME");
// Delete the symbol
await am.deleteWatchlistSymbol(watchlist?.id, "GME");
// Delete the watchlist
await am.deleteWatchlist(watchlist?.id);
// Delete all watchlists
await am.deleteAllWatchlists();
```

#### Calendar and market clock

The calendar API provides a way to request a range of dates that the market is open for, with the date, open, and close timestamps.
The market clock is the current time, whether the market is open, when the market opens next, and when the market closes next.

```dart
/// Retrieve a specific date
Calendar? calendar = await am.getCalendarDate(const DateTime(2022, 11, 1));
/// Retrieves a range of dates
List<Calendar>? calendars = await am.getCalendarDates(
    start: const DateTime(2022, 10, 25), end: const DateTime(2022, 10, 31));
/// Retrieve the market clock
Clock? clock = await am.getMarketClock();
```

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