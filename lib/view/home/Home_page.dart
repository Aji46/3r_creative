import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_creative/Controller/provider/get_spot_provider.dart';
import 'package:r_creative/contants/color.dart';
import 'package:r_creative/services/websocket_service.dart';
import 'package:r_creative/view/home/widgets/Commoditycard.dart';
import 'package:r_creative/view/home/widgets/Livemarket.dart';
import 'package:r_creative/view/widgets/Coustom_AppBar.dart';


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
    final serverUrl = "https://capital-server-gnsu.onrender.com";
    
    _webSocketService.connect(serverUrl);
    _webSocketService.stream.listen(
      (data) => _handleWebSocketData(data),
      onError: (_) => _handleConnectionIssue(),
      onDone: () => _handleConnectionIssue(),
    );
  }

  void _handleWebSocketData(dynamic data) {
    if (data is! String) return;
    
    try {
      final parsedData = jsonDecode(data);
      if (parsedData is Map<String, dynamic> && 
          (parsedData['type'] == 'market-data' || parsedData['event'] == 'market-data')) {
        setState(() => liveMarketData = parsedData['data'] ?? {});
      }
    } catch (e) {
      print('Error parsing WebSocket data: $e');
    }
  }

  void _handleConnectionIssue() {
    setState(() => liveMarketData = {});
    if (mounted) {
      Future.delayed(const Duration(seconds: 5), _connectToWebSocket);
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
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: Consumer<SpotratesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return _buildLoadingView();
          }
          return provider.spotrates == null 
              ? _buildErrorView(provider)
              : _buildContentView(provider);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.mycolor3,
        onPressed: () => Provider.of<SpotratesProvider>(context, listen: false).getSpotrates(),
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: CircularProgressIndicator(color: MyColors.mycolor3),
    );
  }

  Widget _buildErrorView(SpotratesProvider provider) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLiveMarketContainer(),
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            const Text('Failed to load data', 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => provider.getSpotrates(),
              child: const Text('Retry'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildContentView(SpotratesProvider provider) {
    return RefreshIndicator(
      color: MyColors.mycolor3,
      onRefresh: () => provider.getSpotrates(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildLiveMarketContainer(),
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveMarketContainer() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2, blurRadius: 5, offset: const Offset(0, 3),
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
    );
  }
}