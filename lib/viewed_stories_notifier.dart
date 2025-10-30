import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:heheheh/models/story.dart';

class ViewedStoriesNotifier extends ChangeNotifier {
  static const _key = 'viewed_stories';
  List<Story> _viewedStories = [];
  final int _maxViewedStories = 20; // Limit the number of viewed stories

  List<Story> get viewedStories => _viewedStories;

  ViewedStoriesNotifier() {
    loadViewedStories();
  }

  Future<void> loadViewedStories() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      _viewedStories = jsonList.map((json) => Story.fromJson(json)).toList();
      notifyListeners();
    }
  }

  Future<void> addViewedStory(Story story) async {
    // Remove if already exists to move it to the top
    _viewedStories.removeWhere((s) => s.id == story.id);

    // Add to the beginning of the list
    _viewedStories.insert(0, story);

    // Limit the list size
    if (_viewedStories.length > _maxViewedStories) {
      _viewedStories = _viewedStories.sublist(0, _maxViewedStories);
    }

    await _saveViewedStories();
    notifyListeners();
  }

  Future<void> _saveViewedStories() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _viewedStories.map((s) => s.toJson()).toList();
    await prefs.setString(_key, json.encode(jsonList));
  }

  Future<void> clearViewedStories() async {
    _viewedStories.clear();
    await _saveViewedStories();
    notifyListeners();
  }
}
