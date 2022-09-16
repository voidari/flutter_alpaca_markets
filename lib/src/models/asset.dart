library alpaca_markets;

/// The asset object used to hold both equity and crypto
/// asset data returned from the asset requests.
class Asset {
  static const String _jsonKeyId = "id";
  static const String _jsonKeyClass = "class";
  static const String _jsonKeyExchange = "exchange";
  static const String _jsonKeySymbol = "symbol";
  static const String _jsonKeyName = "name";
  static const String _jsonKeyStatus = "status";
  static const String _jsonKeyTradable = "tradable";
  static const String _jsonKeyMarginable = "marginable";
  static const String _jsonKeyShortable = "shortable";
  static const String _jsonKeyEasyToBorrow = "easy_to_borrow";
  static const String _jsonKeyFractionable = "fractionable";
  static const String _jsonKeyMinOrderSize = "min_order_size";
  static const String _jsonKeyMinTradeIncrement = "min_trade_increment";
  static const String _jsonKeyPriceIncrement = "price_increment";
  static const String _jsonKeyMaintenanceMarginRequirement =
      "maintenance_margin_requirement";

  /// Asset ID.
  final String id;

  /// The type of asset, ex: 'crypto'
  final String assetClass;

  /// The name of the exchange, ex: 'FTXU'
  final String exchange;

  /// Symbol of asset
  final String symbol;

  /// The name of the asset
  final String name;

  /// 'active' or 'inactive'
  final String status;

  /// Asset is tradable on Alpaca or not.
  final bool tradable;

  /// Asset is marginable or not.
  final bool marginable;

  /// Asset is shortable or not.
  final bool shortable;

  /// Asset is easy-to-borrow or not.
  final bool easyToBorrow;

  /// Asset is fractionable or not.
  final bool fractionable;

  /// Minimum order size. Field available for crypto only.
  /// This value is a number.
  final String? minOrderSize;

  /// Amount a trade quantity can be incremented by. Field available
  /// for crypto only.
  /// This value is a number.
  final String? minTradeIncrement;

  /// Amount the price can be incremented by. Field available for crypto only.
  /// This value is a number.
  final String? priceIncrement;

  /// Shows the % margin requirement for the asset (equities only).
  final int? maintenanceMarginRequirement;

  /// The constructor of the asset
  Asset(
      this.id,
      this.assetClass,
      this.exchange,
      this.symbol,
      this.name,
      this.status,
      this.tradable,
      this.marginable,
      this.shortable,
      this.easyToBorrow,
      this.fractionable,
      this.minOrderSize,
      this.minTradeIncrement,
      this.priceIncrement,
      this.maintenanceMarginRequirement);

  /// Utility used to get the boolean active status.
  bool isActive() {
    return status == "active";
  }

  /// Constructs an asset from the provided JSON data.
  static Asset? fromJson(Map<String, dynamic> json) {
    // Parse the ID
    if (!json.containsKey(_jsonKeyId)) {
      return null;
    }
    String id = json[_jsonKeyId]!;
    // Parse the class
    if (!json.containsKey(_jsonKeyClass)) {
      return null;
    }
    String assetClass = json[_jsonKeyClass]!;
    // Parse the exchange
    if (!json.containsKey(_jsonKeyExchange)) {
      return null;
    }
    String exchange = json[_jsonKeyExchange]!;
    // Parse the symbol
    if (!json.containsKey(_jsonKeySymbol)) {
      return null;
    }
    String symbol = json[_jsonKeySymbol]!;
    // Parse the name
    String name = "";
    if (json.containsKey(_jsonKeyName)) {
      name = json[_jsonKeyName]!;
    }
    // Parse the status
    String status = "";
    if (json.containsKey(_jsonKeyStatus)) {
      status = json[_jsonKeyStatus]!;
    }
    // Parse the tradable
    bool tradable = false;
    if (json.containsKey(_jsonKeyTradable)) {
      tradable = json[_jsonKeyTradable]!;
    }
    // Parse the marginable
    bool marginable = false;
    if (json.containsKey(_jsonKeyMarginable)) {
      marginable = json[_jsonKeyMarginable]!;
    }
    // Parse the shortable
    bool shortable = false;
    if (json.containsKey(_jsonKeyShortable)) {
      shortable = json[_jsonKeyShortable]!;
    }
    // Parse the easyToBorrow
    bool easyToBorrow = false;
    if (json.containsKey(_jsonKeyEasyToBorrow)) {
      easyToBorrow = json[_jsonKeyEasyToBorrow]!;
    }
    // Parse the tradable
    bool fractionable = false;
    if (json.containsKey(_jsonKeyFractionable)) {
      fractionable = json[_jsonKeyFractionable]!;
    }
    // Parse the minOrderSize
    String? minOrderSize;
    if (json.containsKey(_jsonKeyMinOrderSize)) {
      minOrderSize = json[_jsonKeyMinOrderSize]!;
    }
    // Parse the minTradeIncrement
    String? minTradeIncrement;
    if (json.containsKey(_jsonKeyMinTradeIncrement)) {
      minTradeIncrement = json[_jsonKeyMinTradeIncrement]!;
    }
    // Parse the priceIncrement
    String? priceIncrement;
    if (json.containsKey(_jsonKeyPriceIncrement)) {
      priceIncrement = json[_jsonKeyPriceIncrement]!;
    }
    // Parse the status
    int? maintenanceMarginRequirement;
    if (json.containsKey(_jsonKeyMaintenanceMarginRequirement)) {
      maintenanceMarginRequirement =
          json[_jsonKeyMaintenanceMarginRequirement]!;
    }
    // Create the asset
    return Asset(
        id,
        assetClass,
        exchange,
        symbol,
        name,
        status,
        tradable,
        marginable,
        shortable,
        easyToBorrow,
        fractionable,
        minOrderSize,
        minTradeIncrement,
        priceIncrement,
        maintenanceMarginRequirement);
  }

  /// Creates a JSON object given the current asset data
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json.putIfAbsent(_jsonKeyId, () => id);
    json.putIfAbsent(_jsonKeyClass, () => assetClass);
    json.putIfAbsent(_jsonKeyExchange, () => exchange);
    json.putIfAbsent(_jsonKeySymbol, () => symbol);
    if (name.isNotEmpty) {
      json.putIfAbsent(_jsonKeyName, () => name);
    }
    if (status.isNotEmpty) {
      json.putIfAbsent(_jsonKeyStatus, () => status);
    }
    json.putIfAbsent(_jsonKeyTradable, () => tradable);
    json.putIfAbsent(_jsonKeyMarginable, () => marginable);
    json.putIfAbsent(_jsonKeyShortable, () => shortable);
    json.putIfAbsent(_jsonKeyEasyToBorrow, () => easyToBorrow);
    json.putIfAbsent(_jsonKeyFractionable, () => fractionable);
    if (minOrderSize != null) {
      json.putIfAbsent(_jsonKeyMinOrderSize, () => minOrderSize);
    }
    if (minTradeIncrement != null) {
      json.putIfAbsent(_jsonKeyMinTradeIncrement, () => minTradeIncrement);
    }
    if (priceIncrement != null) {
      json.putIfAbsent(_jsonKeyPriceIncrement, () => priceIncrement);
    }
    if (maintenanceMarginRequirement != null) {
      json.putIfAbsent(_jsonKeyMaintenanceMarginRequirement,
          () => maintenanceMarginRequirement);
    }
    return json;
  }
}
