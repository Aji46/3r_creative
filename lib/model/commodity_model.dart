class GetCommodities {
  final bool success;
  final List<String> commodities;
  final String message;

  GetCommodities({
    required this.success,
    required this.commodities,
    required this.message,
  });

  factory GetCommodities.fromJson(Map<String, dynamic> json) {
    return GetCommodities(
      success: json['success'] ?? false,
      commodities: List<String>.from(json['commodities'] ?? []),
      message: json['message'] ?? '',
    );
  }
}

class Commodity {
  final String metal;
  final int purity;
  final int unit;
  final String weight;
  final int buyPremium;
  final int sellPremium;
  final int buyCharge;
  final int sellCharge;
  final String id;

  Commodity({
    required this.metal,
    required this.purity,
    required this.unit,
    required this.weight,
    required this.buyPremium,
    required this.sellPremium,
    required this.buyCharge,
    required this.sellCharge,
    required this.id,
  });

  factory Commodity.fromJson(Map<String, dynamic> json) {
    return Commodity(
      metal: json['metal'] ?? '',
      purity: json['purity'] ?? 0,
      unit: json['unit'] ?? 0,
      weight: json['weight'] ?? '',
      buyPremium: json['buyPremium'] ?? 0,
      sellPremium: json['sellPremium'] ?? 0,
      buyCharge: json['buyCharge'] ?? 0,
      sellCharge: json['sellCharge'] ?? 0,
      id: json['_id'] ?? '',
    );
  }
} 