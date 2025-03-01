import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_creative/Controller/provider/get_spot_provider.dart';
import 'package:r_creative/contants/color.dart';
import 'package:r_creative/view/widgets/Coustom_AppBar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                ],
              ),
            );
          }
          return RefreshIndicator(
            color: MyColors.mycolor3,
            onRefresh: () => provider.getSpotrates(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: provider.spotrates!.info.commodities.length,
              itemBuilder: (context, index) {
                final commodity = provider.spotrates!.info.commodities[index];
                return CommodityCard(commodity: commodity);
              },
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

class CommodityCard extends StatelessWidget {
  final dynamic commodity;

  const CommodityCard({super.key, required this.commodity});

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
                  onPressed: () {
                    // Details action
                  },
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