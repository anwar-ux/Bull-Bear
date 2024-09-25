class Stock {
  // final int id;
  final String companyName;
  final String stockPrice;
  final String stockSymbol;

  Stock({
    //required this.id,
    required this.companyName,
    required this.stockPrice,
    required this.stockSymbol,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
       // id: json['id'],
        companyName: json['companyName'],
      stockSymbol: json['stockSymbol'],
      stockPrice: json['stockPrice'],
      );
}
