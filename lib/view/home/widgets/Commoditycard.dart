import 'package:flutter/material.dart';
import 'package:r_creative/contants/color.dart';

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
            colors: [Color(0xFF1A1A1A), Color(0xFF000000)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildLiveData(),
              const SizedBox(height: 16),
              _buildInfoSection(),
              _buildDetailsButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
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
    );
  }

  Widget _buildLiveData() {
    if (liveData == null) return const SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
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
    );
  }

  Widget _buildInfoSection() {
    return Column(
      children: [
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
      ],
    );
  }

  Widget _buildDetailsButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.info_outline, color: MyColors.mycolor3, size: 16),
        label: const Text(
          'Details',
          style: TextStyle(color: MyColors.mycolor3, fontSize: 12),
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