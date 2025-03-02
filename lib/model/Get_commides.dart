class GetCommodities {
  final bool success;
  final List<String> commodities;
  final String message;

  GetCommodities({
    required this.success,
    required this.commodities,
    required this.message,
  });

  // Add the fromJson factory constructor
  factory GetCommodities.fromJson(Map<String, dynamic> json) {
    return GetCommodities(
      success: json['success'] ?? false,
      commodities: List<String>.from(json['commodities'] ?? []),
      message: json['message'] ?? '',
    );
  }
}