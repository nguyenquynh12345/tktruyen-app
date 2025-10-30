import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:heheheh/models/story.dart';

class FavoriteService {
  static const _key = 'favorite_stories';

  static Future<void> addFavorite(Story story) async {
    final favorites = await getFavorites();
    if (!favorites.any((s) => s.id == story.id)) {
      favorites.add(story);
      await _saveFavorites(favorites);
    }
  }

  static Future<void> removeFavorite(int storyId) async {
    final favorites = await getFavorites();
    favorites.removeWhere((s) => s.id == storyId);
    await _saveFavorites(favorites);
  }

  static Future<List<Story>> getAllFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => Story.fromJson(json)).toList();
    }
    return [];
  }

  static Future<List<Story>> getFavorites({int page = 1, int limit = 10}) async {
    final allFavorites = await getAllFavorites();
    final startIndex = (page - 1) * limit;
    if (startIndex >= allFavorites.length) {
      return [];
    }
    final endIndex = (startIndex + limit).clamp(0, allFavorites.length);
    return allFavorites.sublist(startIndex, endIndex);
  }

  static Future<bool> isFavorite(int storyId) async {
    final favorites = await getFavorites();
    return favorites.any((s) => s.id == storyId);
  }

  static Future<void> _saveFavorites(List<Story> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = favorites.map((s) => s.toJson()).toList();
    await prefs.setString(_key, json.encode(jsonList));
  }
}
