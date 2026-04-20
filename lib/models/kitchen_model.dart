class KitchenModel {
  final String id;
  final String originalImagePath;
  final String resultImagePath;
  final String styleName;
  final DateTime timestamp;
  final Map<String, dynamic> settings;
  final bool isFavorite;

  const KitchenModel({
    required this.id,
    required this.originalImagePath,
    required this.resultImagePath,
    required this.styleName,
    required this.timestamp,
    this.settings = const {},
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'originalImagePath': originalImagePath,
      'resultImagePath': resultImagePath,
      'styleName': styleName,
      'timestamp': timestamp.toIso8601String(),
      'settings': settings,
      'isFavorite': isFavorite,
    };
  }

  factory KitchenModel.fromJson(Map<String, dynamic> json) {
    return KitchenModel(
      id: json['id'],
      originalImagePath: json['originalImagePath'],
      resultImagePath: json['resultImagePath'],
      styleName: json['styleName'],
      timestamp: DateTime.parse(json['timestamp']),
      settings: json['settings'] ?? {},
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
