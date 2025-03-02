class PriceCalculator {
  static const Map<String, double> unitMultiplierMap = {
    "GM": 1.0,
    "KG": 1000.0,
    "TTB": 116.64,
    "TOLA": 11.664,
    "OZ": 31.1034768,
  };

  static double calculateBuyPrice({
    required double marketRate,
    required double unit,
    required String weight,
    required double buyCharge,
    required double buyPremium,
    required double purity,
  }) {
    double unitMultiplier = unitMultiplierMap[weight.toUpperCase()] ?? 1.0;
    double purityPower = purity / 100.0;

    double biddingValue = marketRate + buyPremium;
    double biddingPrice = (biddingValue / 31.103) * 3.674;  // USD to AED conversion
    return (biddingPrice * unitMultiplier * unit * purityPower) + buyCharge;
  }

  static double calculateSellPrice({
    required double marketRate,
    required double unit,
    required String weight,
    required double sellCharge,
    required double sellPremium,
    required double purity,
  }) {
    double unitMultiplier = unitMultiplierMap[weight.toUpperCase()] ?? 1.0;
    double purityPower = purity / 100.0;

    double askingValue = marketRate + sellPremium;
    double askingPrice = (askingValue / 31.103) * 3.674;  // USD to AED conversion
    return (askingPrice * unitMultiplier * unit * purityPower) + sellCharge;
  }

  static String getSymbolForMetal(String metal) {
    switch (metal.toUpperCase()) {
      case 'GOLD':
        return 'XAU/USD';
      case 'SILVER':
        return 'XAG/USD';
      default:
        return metal.toUpperCase();
    }
  }
} 