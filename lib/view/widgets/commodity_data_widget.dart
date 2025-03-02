import 'package:flutter/material.dart';
import 'package:r_creative/services/websocket_service.dart';

class CommodityDataWidget extends StatefulWidget {
  final String serverUrl;
  final String serverName;
  final double maxWidth;
  final double maxHeight;

  const CommodityDataWidget({
    Key? key,
    required this.serverUrl,
    required this.serverName,
    required this.maxWidth,
    required this.maxHeight,
  }) : super(key: key);

  @override
  _CommodityDataWidgetState createState() => _CommodityDataWidgetState();
}

class _CommodityDataWidgetState extends State<CommodityDataWidget> {
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
      if (widget.serverUrl.isEmpty) throw Exception('Server URL is empty');
      
      _webSocketService.connect(widget.serverUrl);
      _webSocketService.stream.listen(
        (data) => setState(() => liveData.add(data)),
        onError: (error) => setState(() => errorMessage = 'WebSocket error: $error'),
        onDone: () => setState(() => errorMessage = 'WebSocket connection closed'),
      );
      setState(() => isLoading = false);
    } catch (e) {
      setState(() {
        errorMessage = 'Error connecting to WebSocket: $e';
        isLoading = false;
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
    return Container(
      constraints: BoxConstraints(
        maxWidth: widget.maxWidth,
        maxHeight: widget.maxHeight,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Live Data from ${widget.serverName}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (errorMessage.isNotEmpty) {
      return Text(errorMessage, style: const TextStyle(color: Colors.red));
    }
    if (liveData.isEmpty) return const Text('No data available');

    return Expanded(
      child: ListView.builder(
        itemCount: liveData.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(liveData[index]),
        ),
      ),
    );
  }
}