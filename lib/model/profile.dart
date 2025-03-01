class GetProfile {
  String message;
  bool success;
  Info info;

  GetProfile({
    required this.message,
    required this.success,
    required this.info,
  });

  factory GetProfile.fromJson(Map<String, dynamic> json) {
    return GetProfile(
      message: json['message'] ?? 'No message',
      success: json['success'] ?? false,
      info: Info.fromJson(json['info'] ?? {}),
    );
  }
}

class Info {
  String id;
  String userName;
  String companyName;
  String address;
  String email;
  int contact;
  int whatsapp;

  Info({
    required this.id,
    required this.userName,
    required this.companyName,
    required this.address,
    required this.email,
    required this.contact,
    required this.whatsapp,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      id: json['_id'] ?? '',
      userName: json['userName'] ?? 'N/A',
      companyName: json['companyName'] ?? 'N/A',
      address: json['address'] ?? 'N/A',
      email: json['email'] ?? 'N/A',
      contact: json['contact'] ?? 0,
      whatsapp: json['whatsapp'] ?? 0,
    );
  }
}
