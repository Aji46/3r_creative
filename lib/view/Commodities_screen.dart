import 'package:flutter/material.dart';
import 'package:r_creative/Controller/Services/apiservices_server.dart';
import 'package:r_creative/services/websocket_service.dart';
import 'package:r_creative/view/widgets/commodity_data_widget.dart';

class CommoditiesScreen extends StatefulWidget {
  const CommoditiesScreen({Key? key}) : super(key: key);

  @override
  _CommoditiesScreenState createState() => _CommoditiesScreenState();
}

class _CommoditiesScreenState extends State<CommoditiesScreen> {
  final ApiService _apiService = ApiService();
  String serverName = '';
  String serverUrl = '';
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchServerDetails();
  }

  Future<void> _fetchServerDetails() async {
    try {
      final serverData = await _apiService.getServer();
      setState(() {
        serverName = serverData.info.serverName;
        serverUrl = serverData.info.serverUrl;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching server details: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commodities'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (errorMessage.isNotEmpty)
                    Center(
                      child: Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  else
                    CommodityDataWidget(
                      serverUrl: serverUrl,
                      serverName: serverName,
                      maxHeight: constraints.maxHeight * 0.8,
                      maxWidth: constraints.maxWidth,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}