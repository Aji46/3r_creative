import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_creative/Controller/provider/get_spot_provider.dart';
import 'package:r_creative/contants/color.dart';
import 'package:r_creative/view/Commodities_screen.dart';
import 'package:r_creative/view/widgets/Coustom_AppBar.dart';
import 'package:r_creative/services/websocket_service.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final WebSocketService _webSocketService = WebSocketService();
  Map<String, dynamic> liveMarketData = {};

  @override
  void initState() {
    super.initState();
    _connectToWebSocket();
  }

  void _connectToWebSocket() {
    try {
      final serverUrl = "https://capital-server-gnsu.onrender.com";
      print('Connecting to WebSocket server: $serverUrl');
      
      _webSocketService.connect(serverUrl);
      _webSocketService.stream.listen(
        (data) {
          setState(() {
            try {
              if (data is String) {
                final parsedData = jsonDecode(data);
                if (parsedData is Map<String, dynamic>) {
                  // Check if this is a market data update
                  if (parsedData['type'] == 'market-data' || parsedData['event'] == 'market-data') {
                    liveMarketData = parsedData['data'] ?? {};
                    print('Received market data: $liveMarketData');
                  }
                }
              }
            } catch (e) {
              print('Error parsing WebSocket data: $e');
            }
          });
        },
        onError: (error) {
          print('WebSocket error: $error');
          setState(() {
            liveMarketData = {};
          });
          // Attempt to reconnect after a delay
          Future.delayed(const Duration(seconds: 5), () {
            if (mounted) {
              _connectToWebSocket();
            }
          });
        },
        onDone: () {
          print('WebSocket connection closed');
          // Attempt to reconnect after a delay
          Future.delayed(const Duration(seconds: 5), () {
            if (mounted) {
              _connectToWebSocket();
            }
          });
        },
      );
    } catch (e) {
      print('Error connecting to WebSocket: $e');
      // Attempt to reconnect after a delay
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          _connectToWebSocket();
        }
      });
    }
  }

  @override
  void dispose() {
    _webSocketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Home",
        onLeadingPressed: () {},
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<SpotratesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: MyColors.mycolor3,
              ),
            );
          }
          if (provider.spotrates == null) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Live Market Data Container at the top
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Live Market Updates',
                              style: TextStyle(
                                color: MyColors.mycolor3,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          LiveMarketTicker(marketData: liveMarketData),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Failed to load data',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => provider.getSpotrates(),
                      child: const Text('Retry'),
                    ),
                    const SizedBox(height: 16), // Add bottom padding
                  ],
                ),
              ),
            );
          }
          return RefreshIndicator(
            color: MyColors.mycolor3,
            onRefresh: () => provider.getSpotrates(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  // Live Market Data Container
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Live Market Updates',
                            style: TextStyle(
                              color: MyColors.mycolor3,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        LiveMarketTicker(marketData: liveMarketData),
                      ],
                    ),
                  ),
                  // Commodity List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16.0),
                    itemCount: provider.spotrates!.info.commodities.length,
                    itemBuilder: (context, index) {
                      final commodity = provider.spotrates!.info.commodities[index];
                      return CommodityCard(
                        commodity: commodity,
                        liveData: liveMarketData[commodity.metal.toLowerCase()],
                      );
                    },
                  ),
                  const SizedBox(height: 16), // Add bottom padding
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.mycolor3,
        onPressed: () {
          Provider.of<SpotratesProvider>(context, listen: false).getSpotrates();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class LiveMarketTicker extends StatelessWidget {
  final Map<String, dynamic> marketData;

  const LiveMarketTicker({super.key, required this.marketData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildMarketItem('Gold', marketData['gold']),
          _buildMarketItem('Silver', marketData['silver']),
          _buildMarketItem('Platinum', marketData['platinum']),
          _buildMarketItem('Copper', marketData['copper']),
        ],
      ),
    );
  }

  Widget _buildMarketItem(String metal, Map<String, dynamic>? data) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: MyColors.mycolor3.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            metal,
            style: TextStyle(
              color: MyColors.mycolor3,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          if (data != null) ...[
            Text(
              'Bid: ${data['bid'] ?? 'N/A'}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            Text(
              'Ask: ${data['ask'] ?? 'N/A'}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ] else
            const Text(
              'Loading...',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
        ],
      ),
    );
  }
}

class CommodityCard extends StatelessWidget {
  final dynamic commodity;
  final Map<String, dynamic>? liveData;

  const CommodityCard({
    super.key,
    required this.commodity,
    this.liveData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 0, 0, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A1A),
              Color(0xFF000000),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      commodity.metal,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: MyColors.mycolor3,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: MyColors.mycolor3.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${commodity.purity}%',
                      style: const TextStyle(
                        color: MyColors.mycolor3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              if (liveData != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildLivePrice('Bid', liveData!['bid']?.toString() ?? 'N/A'),
                      _buildLivePrice('Ask', liveData!['ask']?.toString() ?? 'N/A'),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 16),
              _buildInfoRow(
                title: "Buy/Sell Premium",
                value1: "${commodity.buyPremium}",
                value2: "${commodity.sellPremium}",
                icon1: Icons.trending_up,
                icon2: Icons.trending_down,
              ),
              const Divider(color: Colors.grey, height: 24),
              _buildInfoRow(
                title: "Weight & Units",
                value1: "${commodity.weight}",
                value2: "${commodity.unit}",
                icon1: Icons.balance,
                icon2: Icons.category,
              ),
              const Divider(color: Colors.grey, height: 24),
              _buildInfoRow(
                title: "Charges",
                value1: "Buy: ${commodity.buyCharge}",
                value2: "Sell: ${commodity.sellCharge}",
                icon1: Icons.payments,
                icon2: Icons.monetization_on,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.info_outline, color: MyColors.mycolor3, size: 16),
                  label: const Text(
                    'Details',
                    style: TextStyle(color: MyColors.mycolor3, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLivePrice(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: MyColors.mycolor2.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: MyColors.mycolor3,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required String title,
    required String value1,
    required String value2,
    required IconData icon1,
    required IconData icon2,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: MyColors.mycolor2.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(icon1, size: 16, color: MyColors.mycolor3),
                  const SizedBox(width: 8),
                  Text(
                    value1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: MyColors.mycolor2,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(icon2, size: 16, color: MyColors.mycolor3),
                  const SizedBox(width: 8),
                  Text(
                    value2,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: MyColors.mycolor2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}