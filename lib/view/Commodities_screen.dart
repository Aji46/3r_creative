import 'package:flutter/material.dart';
import 'package:r_creative/Controller/Services/apiservices_server.dart';
import 'package:r_creative/services/websocket_service.dart';

// A reusable widget that displays commodity data in a container
class CommodityDataContainer extends StatefulWidget {
  final String serverUrl;
  final String serverName;
  
  // Optional parameters for customization
  final double width;
  final double height;
  final Color backgroundColor;
  
  const CommodityDataContainer({
    Key? key,
    required this.serverUrl,
    required this.serverName,
    this.width = double.infinity,
    this.height = 300,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  _CommodityDataContainerState createState() => _CommodityDataContainerState();
}

class _CommodityDataContainerState extends State<CommodityDataContainer> {
  final WebSocketService _webSocketService = WebSocketService();
  List<String> liveData = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _connectToWebSocket();
  }

  Future<void> _connectToWebSocket() async {
    try {
      if (widget.serverUrl.isEmpty) {
        throw Exception('Server URL is empty');
      }
      
      _webSocketService.connect(widget.serverUrl);

      _webSocketService.stream.listen(
        (data) {
          setState(() {
            liveData.add(data); 
          });
        },
        onError: (error) {
          setState(() {
            errorMessage = 'WebSocket error: $error';
          });
          print('WebSocket error: $error');
        },
        onDone: () {
          setState(() {
            errorMessage = 'WebSocket connection closed';
          });
          print('WebSocket connection closed');
        },
      );

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error connecting to WebSocket: $e';
        isLoading = false;
      });
      print('Error connecting to WebSocket: $e');
    }
  }

  @override
  void dispose() {
    _webSocketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Live Data from ${widget.serverName}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          if (isLoading)
            Center(child: CircularProgressIndicator())
          else if (errorMessage.isNotEmpty)
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            )
          else if (liveData.isEmpty)
            Text('No data available')
          else
            Expanded(
              child: ListView.builder(
                itemCount: liveData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(liveData[index]),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

// Modified CommoditiesScreen that uses the container
class CommoditiesScreen extends StatefulWidget {
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
      print('Error fetching server details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commodities'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)))
                : CommodityDataContainer(
                    serverUrl: serverUrl,
                    serverName: serverName,
                    height: MediaQuery.of(context).size.height * 0.8,
                  ),
      ),
    );
  }
}

// Example of another page using the container
class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ApiService _apiService = ApiService();
  String serverName = '';
  String serverUrl = '';
  bool isLoading = true;

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
      print('Error fetching server details: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Other dashboard widgets
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Market Overview',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                
                // Using the commodity container in a smaller size
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CommodityDataContainer(
                    serverUrl: serverUrl,
                    serverName: serverName,
                    height: 200,
                    backgroundColor: Colors.grey[100]!,
                  ),
                ),
                
                // More dashboard widgets can be added here
              ],
            ),
    );
  }
}