class GetServer {
  final bool success;
  final Info info;
  final String message;

  GetServer({
    required this.success,
    required this.info,
    required this.message,
  });

  factory GetServer.fromJson(Map<String, dynamic> json) {
    return GetServer(
      success: json['success'] ?? false,
      info: Info.fromJson(json['info'] ?? {}),
      message: json['message'] ?? '',
    );
  }
}

class Info {
  final String serverUrl;
  final String serverName;

  Info({
    required this.serverUrl,
    required this.serverName,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      serverUrl: json['serverURL'] ?? '',
      serverName: json['serverName'] ?? '',
    );
  }
} 