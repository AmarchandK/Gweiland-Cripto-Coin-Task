class CoinModel {
  final int id;
  final String name;
  final String symbol;
  final Quote quote;

  CoinModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.quote,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) => CoinModel(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        quote: Quote.fromJson(json["quote"]),
      );
}

class Quote {
  final Usd usd;

  Quote({
    required this.usd,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        usd: Usd.fromJson(json["USD"]),
      );
}

class Usd {
  final double price;
  final double percentChange24h;

  Usd({
    required this.price,
    required this.percentChange24h,
  });

  factory Usd.fromJson(Map<String, dynamic> json) => Usd(
        price: json["price"]?.toDouble(),
        percentChange24h: json["percent_change_24h"]?.toDouble(),
      );
}
