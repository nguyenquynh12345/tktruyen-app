import 'package:flutter/material.dart';
import 'package:heheheh/core/services/favorite_service.dart';
import 'package:heheheh/models/story.dart';

class FavoriteNotifier extends ChangeNotifier {
  List<Story> _favoriteStories = [];
  bool _isLoading = false;

  List<Story> get favoriteStories => _favoriteStories;
  bool get isLoading => _isLoading;

  FavoriteNotifier() {
    _loadInitialFavorites();
  }

  Future<void> _loadInitialFavorites() async {
    _isLoading = true;
    notifyListeners();
    _favoriteStories = await FavoriteService.getAllFavorites();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addFavorite(Story story) async {
    if (!_favoriteStories.any((s) => s.id == story.id)) {
      await FavoriteService.addFavorite(story);
      _favoriteStories.add(story);
      notifyListeners();
    }
  }

  Future<void> removeFavorite(int storyId) async {
    await FavoriteService.removeFavorite(storyId);
    _favoriteStories.removeWhere((s) => s.id == storyId);
    notifyListeners();
  }

  bool isFavorite(int storyId) {
    return _favoriteStories.any((s) => s.id == storyId);
  }

  Future<void> refreshFavorites() async {
    _isLoading = true;
    notifyListeners();
    _favoriteStories = await FavoriteService.getAllFavorites();
    _isLoading = false;
    notifyListeners();
  }
}
