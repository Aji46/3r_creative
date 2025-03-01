// To parse this JSON data, do
//
//     final loginUser = loginUserFromJson(jsonString);

import 'dart:convert';

LoginUser loginUserFromJson(String str) => LoginUser.fromJson(json.decode(str));

String loginUserToJson(LoginUser data) => json.encode(data.toJson());

class LoginUser {
    final String token;
    final UserInfo info;
    final bool status;
    final String message;

    LoginUser({
        required this.token,
        required this.info,
        required this.status,
        required this.message,
    });

    factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
        token: json["token"] ?? "",
        info: UserInfo.fromJson(json["info"] ?? {}),
        status: json["status"] ?? false,
        message: json["message"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "info": info.toJson(),
        "status": status,
        "message": message,
    };
}

class UserInfo {
    final String adminId;
    final String userName;
    final String email;
    final String companyName;
    final String address;
    final String contact;
    final String whatsapp;
    final String role;
    final bool isActive;

    UserInfo({
        required this.adminId,
        required this.userName,
        required this.email,
        required this.companyName,
        required this.address,
        required this.contact,
        required this.whatsapp,
        required this.role,
        required this.isActive,
    });

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        adminId: json["admin_id"] ?? "",
        userName: json["user_name"] ?? "",
        email: json["email"] ?? "",
        companyName: json["company_name"] ?? "",
        address: json["address"] ?? "",
        contact: json["contact"]?.toString() ?? "",
        whatsapp: json["whatsapp"]?.toString() ?? "",
        role: json["role"] ?? "",
        isActive: json["is_active"] ?? false,
    );

    Map<String, dynamic> toJson() => {
        "admin_id": adminId,
        "user_name": userName,
        "email": email,
        "company_name": companyName,
        "address": address,
        "contact": contact,
        "whatsapp": whatsapp,
        "role": role,
        "is_active": isActive,
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
