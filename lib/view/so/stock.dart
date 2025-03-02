// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class MarketDataScreen extends StatefulWidget {
//   @override
//   _MarketDataScreenState createState() => _MarketDataScreenState();
// }

// class _MarketDataScreenState extends State<MarketDataScreen> {
//   final String adminId = String.fromEnvironment('ADMIN_ID', defaultValue: '66e994239654078fd531dc2a');
//   final String socketSecretKey = String.fromEnvironment('SOCKET_SECRET_KEY', defaultValue: 'aurify@123');
//   final String baseUrl = "https://api.task.aurify.ae";

//   Map<String, dynamic> marketData = {};
//   List<dynamic> commodities = [];
//   String? serverURL;
//   List<dynamic> news = [];
//   String? error;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       final spotRatesRes = await fetchDataFromApi('get-spotrates/$adminId');
//       final serverURLRes = await fetchDataFromApi('get-server');
//       final newsRes = await fetchDataFromApi('get-news/$adminId');
//       final commoditiesRes = await fetchDataFromApi('get-commodities/$adminId');

//       setState(() {
//         commodities = commoditiesRes?['commodities'] ?? [];
//         serverURL = serverURLRes?['info']?['serverURL'];
//         news = newsRes?['news']?['news'] ?? [];
//       });

//       if (serverURL != null) {
//         connectSocket(serverURL!);
//       }
//     } catch (e) {
//       setState(() => error = "An error occurred while fetching data");
//       print("Error fetching data: $e");
//     }
//   }

//   Future<Map<String, dynamic>?> fetchDataFromApi(String endpoint) async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         print("Failed to load $endpoint: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error fetching $endpoint: $e");
//     }
//     return null;
//   }

//   void connectSocket(String url) {
//     IO.Socket socket = IO.io(url, <String, dynamic>{
//       'query': {'secret': socketSecretKey},
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });

//     socket.connect();

//     socket.on('connect', (_) {
//       print('Connected to WebSocket server');
//       socket.emit('request-data', []);
//     });

//     socket.on('disconnect', (_) => print('Disconnected from WebSocket server'));

//     socket.on('market-data', (data) {
//       if (data != null && data['symbol'] != null) {
//         setState(() {
//           marketData[data['symbol']] = {
//             ...?marketData[data['symbol']],
//             ...data,
//             'bidChanged': marketData[data['symbol']] != null && data['bid'] != marketData[data['symbol']]['bid']
//                 ? (data['bid'] > marketData[data['symbol']]['bid'] ? 'up' : 'down')
//                 : null,
//           };
//         });
//       } else {
//         print("Received malformed market data: $data");
//       }
//     });

//     socket.on('error', (error) {
//       print("WebSocket error: $error");
//       setState(() => this.error = "An error occurred while receiving data");
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Market Data")),
//       body: Center(
//         child: error != null
//             ? Text(error!)
//             : Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: commodities.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(title: Text(commodities[index].toString()));
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }

// // Helper functions
// double getBidAskValue(String metal) {
//   // Placeholder for bid/ask fetching logic
//   return 2000.0; // Example: Replace with actual API data
// }

// double calculatePurityPower(double purity) {
//   return purity / 100.0; // Example: If purity is 99, returns 0.99
// }

// void processCommodity(Map<String, dynamic> commodity) {
//   double bid = getBidAskValue(commodity['metal'].toLowerCase());
//   double ask = getBidAskValue(commodity['metal'].toLowerCase());

//   double unit = (commodity['unit'] as num).toDouble();
//   String weight = commodity['weight'];
//   double buyCharge = (commodity['buyCharge'] as num).toDouble();
//   double sellCharge = (commodity['sellCharge'] as num).toDouble();
//   double buyPremium = (commodity['buyPremium'] as num).toDouble();
//   double sellPremium = (commodity['sellPremium'] as num).toDouble();
//   double purity = (commodity['purity'] as num).toDouble();

//   Map<String, double> unitMultiplierMap = {
//     "GM": 1.0,
//     "KG": 1000.0,
//     "TTB": 116.64,
//     "TOLA": 11.664,
//     "OZ": 31.1034768,
//   };

//   double unitMultiplier = unitMultiplierMap[weight] ?? 1.0;
//   double purityPower = calculatePurityPower(purity);

//   double biddingValue = bid + buyPremium;
//   double askingValue = ask + sellPremium;
//   double biddingPrice = (biddingValue / 31.103) * 3.674;
//   double askingPrice = (askingValue / 31.103) * 3.674;

//   double buyPrice = (biddingPrice * unitMultiplier * unit * purityPower) + buyCharge;
//   double sellPrice = (askingPrice * unitMultiplier * unit * purityPower) + sellCharge;

//   print("Buy Price: \$${buyPrice.toStringAsFixed(2)}, Sell Price: \$${sellPrice.toStringAsFixed(2)}");
// }
