import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:r_creative/model/Get_spot_Model.dart';

class ApiService {

    static String API_BASE_URL = dotenv.env['API_BASE_URL'] ?? "";
  static String ADMIN_ID = dotenv.env['ADMIN_ID'] ?? "";
  static String HEADER_KEY = dotenv.env['HEADER_KEY'] ?? "";
  static String HEADER_VALUE = dotenv.env['HEADER_VALUE'] ?? "";
  Future<GetSpotrates> fetchSpotrates() async {

   final response = await http.get(Uri.parse("${API_BASE_URL}get-spotrates/$ADMIN_ID"),
       headers: {
          "Content-Type": "application/json",
          HEADER_KEY: HEADER_VALUE,
        },
    );

print('Response Status Code: ${response.statusCode}');
print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
   return GetSpotrates(
  success: jsonData['success'] ?? false, 
  info: Info(
    id: jsonData['info']['id'] ?? "", 
    createdBy: jsonData['info']['createdBy'] ?? "",
    silverAskSpread: (jsonData['info']['silverAskSpread'] ?? 0).toDouble(),
    silverBidSpread: jsonData['info']['silverBidSpread'] ?? 0,
    goldAskSpread: (jsonData['info']['goldAskSpread'] ?? 0).toDouble(),
    goldBidSpread: jsonData['info']['goldBidSpread'] ?? 0,
    copperAskSpread: jsonData['info']['copperAskSpread'] ?? 0,
    copperBidSpread: jsonData['info']['copperBidSpread'] ?? 0,
    platinumAskSpread: jsonData['info']['platinumAskSpread'] ?? 0,
    platinumBidSpread: jsonData['info']['platinumBidSpread'] ?? 0,
    goldLowMargin: jsonData['info']['goldLowMargin'] ?? 0,
    goldHighMargin: jsonData['info']['goldHighMargin'] ?? 0,
    silverLowMargin: jsonData['info']['silverLowMargin'] ?? 0,
    silverHighMargin: jsonData['info']['silverHighMargin'] ?? 0,
    copperLowMargin: jsonData['info']['copperLowMargin'] ?? 0,
    copperHighMargin: jsonData['info']['copperHighMargin'] ?? 0,
    platinumLowMargin: jsonData['info']['platinumLowMargin'] ?? 0,
    platinumHighMargin: jsonData['info']['platinumHighMargin'] ?? 0,
    commodities: (jsonData['info']['commodities'] as List?)?.map((e) => Commodity(
      metal: e['metal'] ?? "", 
      purity: e['purity'] ?? "",
      unit: e['unit'] ?? "",
      weight: e['weight'] ?? "",
      buyPremium: e['buyPremium'] ?? "",
      sellPremium: e['sellPremium'] ?? "",
      buyCharge: e['buyCharge'] ?? "",
      sellCharge: e['sellCharge'] ?? "",
      id: e['_id'] ?? "",
    )).toList() ?? [],
    v: jsonData['info']['__v'] ?? 0, 
  ),
  message: jsonData['message'] ?? "No message",
);

    } else {
      throw Exception('Failed to load spot rates');
    }
  }
}
