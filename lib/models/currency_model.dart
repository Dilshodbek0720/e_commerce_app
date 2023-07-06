class CurrencyModel {
  final String title;
  final String code;
  final String cbPrice;
  final String nbuBuyPrice;
  final String nbuCellPrice;
  final String date;

  CurrencyModel({
    required this.cbPrice,
    required this.code,
    required this.date,
    required this.nbuBuyPrice,
    required this.nbuCellPrice,
    required this.title,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      cbPrice: json["cb_price"] as String? ?? "",
      code: json["code"] as String? ?? "",
      date: json["date"] as String? ?? "",
      nbuBuyPrice: json["nbu_buy_price"] as String? ?? "",
      nbuCellPrice: json["nbu_cell_price"] as String? ?? "",
      title: json["title"] as String? ?? "",
    );
  }
}
