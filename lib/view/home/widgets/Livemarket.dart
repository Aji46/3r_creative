import 'package:flutter/material.dart';
import 'package:r_creative/contants/color.dart';

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