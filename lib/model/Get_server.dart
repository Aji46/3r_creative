class GetServer {
  final bool success;
  final Info info;
  final String message;

  GetServer({
    required this.success,
    required this.info,
    required this.message,
  });

  // Add the fromJson factory constructor
  factory GetServer.fromJson(Map<String, dynamic> json) {
    return GetServer(
      success: json['success'] ?? false,
      info: Info.fromJson(json['info'] ?? {}), // Ensure Info has a fromJson constructor
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

  // Add the fromJson factory constructor
  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      serverUrl: json['serverUrl'] ?? 'https://capital-server-gnsu.onrender.com',
      serverName: json['serverName'] ?? '',
    );
  }
}