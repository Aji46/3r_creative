import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;

  void connect(String serverUrl) {
    try {
      // Format the WebSocket URL correctly
      final uri = Uri.parse(serverUrl);
      final wsUrl = uri.replace(
        scheme: 'ws',
        path: 'socket.io',
        queryParameters: {
          'EIO': '3',
          'transport': 'websocket',
          'secret': 'aurify@123'
        },
      ).toString();
      
      print('Connecting to WebSocket: $wsUrl');
      
      _channel = WebSocketChannel.connect(
        Uri.parse(wsUrl),
      );
      
      // Send initial connection message
      _channel?.sink.add('2probe');
      
      print('WebSocket connected successfully');
    } catch (e) {
      print('WebSocket connection error: $e');
      throw Exception('Failed to connect to WebSocket: $e');
    }
  }

  Stream get stream {
    if (_channel == null) {
      throw Exception('WebSocket is not connected');
    }
    return _channel!.stream.map((message) {
      // Handle Socket.IO protocol messages
      if (message is String) {
        if (message == '3probe') {
          _channel?.sink.add('5'); // Send ping
          return null;
        } else if (message.startsWith('42')) {
          // Extract the actual message data
          try {
            final data = message.substring(2);
            return data;
          } catch (e) {
            print('Error parsing message: $e');
          }
        }
      }
      return message;
    }).where((message) => message != null);
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
    print('WebSocket disconnected');
  }

  bool get isConnected => _channel != null;
}