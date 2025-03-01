class GetSpotrates {
    bool success;
    Info info;
    String message;

    GetSpotrates({
        required this.success,
        required this.info,
        required this.message,
    });

}

class Info {
    String id;
    String createdBy;
    double silverAskSpread;
    int silverBidSpread;
    double goldAskSpread;
    int goldBidSpread;
    int copperAskSpread;
    int copperBidSpread;
    int platinumAskSpread;
    int platinumBidSpread;
    int goldLowMargin;
    int goldHighMargin;
    int silverLowMargin;
    int silverHighMargin;
    int copperLowMargin;
    int copperHighMargin;
    int platinumLowMargin;
    int platinumHighMargin;
    List<Commodity> commodities;
    int v;

    Info({
        required this.id,
        required this.createdBy,
        required this.silverAskSpread,
        required this.silverBidSpread,
        required this.goldAskSpread,
        required this.goldBidSpread,
        required this.copperAskSpread,
        required this.copperBidSpread,
        required this.platinumAskSpread,
        required this.platinumBidSpread,
        required this.goldLowMargin,
        required this.goldHighMargin,
        required this.silverLowMargin,
        required this.silverHighMargin,
        required this.copperLowMargin,
        required this.copperHighMargin,
        required this.platinumLowMargin,
        required this.platinumHighMargin,
        required this.commodities,
        required this.v,
    });

}

class Commodity {
    String metal;
    int purity;
    int unit;
    String weight;
    int buyPremium;
    int sellPremium;
    int buyCharge;
    int sellCharge;
    String id;

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

}
