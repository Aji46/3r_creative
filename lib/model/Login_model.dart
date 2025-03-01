// To parse this JSON data, do
//
//     final loginUser = loginUserFromJson(jsonString);

import 'dart:convert';

LoginUser loginUserFromJson(String str) => LoginUser.fromJson(json.decode(str));

String loginUserToJson(LoginUser data) => json.encode(data.toJson());

class LoginUser {
    String message;
    bool success;
    String userId;
    UserDetails userDetails;
    UserSpotRate userSpotRate;

    LoginUser({
        required this.message,
        required this.success,
        required this.userId,
        required this.userDetails,
        required this.userSpotRate,
    });

    factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
        message: json["message"],
        success: json["success"],
        userId: json["userId"],
        userDetails: UserDetails.fromJson(json["userDetails"]),
        userSpotRate: UserSpotRate.fromJson(json["userSpotRate"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "userId": userId,
        "userDetails": userDetails.toJson(),
        "userSpotRate": userSpotRate.toJson(),
    };
}

class UserDetails {
    String name;
    int contact;
    String location;
    String categoryId;
    String password;
    String passwordAccessKey;
    String id;
    DateTime createdAt;
    int cashBalance;
    String email;
    int goldBalance;
    String categoryName;

    UserDetails({
        required this.name,
        required this.contact,
        required this.location,
        required this.categoryId,
        required this.password,
        required this.passwordAccessKey,
        required this.id,
        required this.createdAt,
        required this.cashBalance,
        required this.email,
        required this.goldBalance,
        required this.categoryName,
    });

    factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        name: json["name"],
        contact: json["contact"],
        location: json["location"],
        categoryId: json["categoryId"],
        password: json["password"],
        passwordAccessKey: json["passwordAccessKey"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        cashBalance: json["cashBalance"],
        email: json["email"],
        goldBalance: json["goldBalance"],
        categoryName: json["categoryName"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "contact": contact,
        "location": location,
        "categoryId": categoryId,
        "password": password,
        "passwordAccessKey": passwordAccessKey,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "cashBalance": cashBalance,
        "email": email,
        "goldBalance": goldBalance,
        "categoryName": categoryName,
    };
}

class UserSpotRate {
    String categoryId;
    int silverAskSpread;
    int silverBidSpread;
    int goldAskSpread;
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
    String id;

    UserSpotRate({
        required this.categoryId,
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
        required this.id,
    });

    factory UserSpotRate.fromJson(Map<String, dynamic> json) => UserSpotRate(
        categoryId: json["categoryId"],
        silverAskSpread: json["silverAskSpread"],
        silverBidSpread: json["silverBidSpread"],
        goldAskSpread: json["goldAskSpread"],
        goldBidSpread: json["goldBidSpread"],
        copperAskSpread: json["copperAskSpread"],
        copperBidSpread: json["copperBidSpread"],
        platinumAskSpread: json["platinumAskSpread"],
        platinumBidSpread: json["platinumBidSpread"],
        goldLowMargin: json["goldLowMargin"],
        goldHighMargin: json["goldHighMargin"],
        silverLowMargin: json["silverLowMargin"],
        silverHighMargin: json["silverHighMargin"],
        copperLowMargin: json["copperLowMargin"],
        copperHighMargin: json["copperHighMargin"],
        platinumLowMargin: json["platinumLowMargin"],
        platinumHighMargin: json["platinumHighMargin"],
        commodities: List<Commodity>.from(json["commodities"].map((x) => Commodity.fromJson(x))),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "silverAskSpread": silverAskSpread,
        "silverBidSpread": silverBidSpread,
        "goldAskSpread": goldAskSpread,
        "goldBidSpread": goldBidSpread,
        "copperAskSpread": copperAskSpread,
        "copperBidSpread": copperBidSpread,
        "platinumAskSpread": platinumAskSpread,
        "platinumBidSpread": platinumBidSpread,
        "goldLowMargin": goldLowMargin,
        "goldHighMargin": goldHighMargin,
        "silverLowMargin": silverLowMargin,
        "silverHighMargin": silverHighMargin,
        "copperLowMargin": copperLowMargin,
        "copperHighMargin": copperHighMargin,
        "platinumLowMargin": platinumLowMargin,
        "platinumHighMargin": platinumHighMargin,
        "commodities": List<dynamic>.from(commodities.map((x) => x.toJson())),
        "_id": id,
    };
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

    factory Commodity.fromJson(Map<String, dynamic> json) => Commodity(
        metal: json["metal"],
        purity: json["purity"],
        unit: json["unit"],
        weight: json["weight"],
        buyPremium: json["buyPremium"],
        sellPremium: json["sellPremium"],
        buyCharge: json["buyCharge"],
        sellCharge: json["sellCharge"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "metal": metal,
        "purity": purity,
        "unit": unit,
        "weight": weight,
        "buyPremium": buyPremium,
        "sellPremium": sellPremium,
        "buyCharge": buyCharge,
        "sellCharge": sellCharge,
        "_id": id,
    };
}
