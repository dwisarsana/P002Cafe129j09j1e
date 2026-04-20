import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/kitchen_model.dart';

class StorageService {
  static const String _historyKey = 'kitchen_history';

  Future<void> saveKitchens(List<KitchenModel> kitchens) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList = kitchens.map((g) => jsonEncode(g.toJson())).toList();
    await prefs.setStringList(_historyKey, jsonList);
  }

  Future<List<KitchenModel>> loadKitchens() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_historyKey);
    
    if (jsonList == null) return [];

    return jsonList.map((jsonStr) {
      return KitchenModel.fromJson(jsonDecode(jsonStr));
    }).toList();
  }

  Future<void> toggleFavorite(String id) async {
    final kitchens = await loadKitchens();
    final index = kitchens.indexWhere((g) => g.id == id);
    if (index != -1) {
      final g = kitchens[index];
      kitchens[index] = KitchenModel(
        id: g.id,
        originalImagePath: g.originalImagePath,
        resultImagePath: g.resultImagePath,
        styleName: g.styleName,
        timestamp: g.timestamp,
        settings: g.settings,
        isFavorite: !g.isFavorite,
      );
      await saveKitchens(kitchens);
    }
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
