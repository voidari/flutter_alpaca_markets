# Alpaca Markets

[![pub package](https://img.shields.io/pub/v/alpaca_markets.svg)](https://pub.dev/packages/alpaca_markets)

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

#### Retrieve account and assets

Additional parameters for the getAssets() request include asset status, asset class, and exchange filters.

The [Account](https://github.com/voidari/flutter/blob/main/alpaca_markets/lib/src/account.dart) and [Asset](https://github.com/voidari/flutter/blob/main/alpaca_markets/lib/src/asset.dart) classes are available for viewing the fields of data.

```dart
Account? account = await am.getAccount();
Asset? asset = await am.getAsset("GRMN");
List<Asset>? assets = await am.getAssets();
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