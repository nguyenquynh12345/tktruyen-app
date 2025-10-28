import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

// 🔹 Model: StoryResponse
class StoryResponse {
  final int id;
  final String storyName;
  final String author;
  final String sourceUrl;
  final String site;
  final String name;
  final String image;
  final bool active;
  final int? chapterFrom;
  final int? chapterTo;
  final String description;

  StoryResponse({
    required this.id,
    required this.storyName,
    required this.author,
    required this.sourceUrl,
    required this.site,
    required this.name,
    required this.image,
    required this.active,
    this.chapterFrom,
    this.chapterTo,
    required this.description,
  });

  factory StoryResponse.fromJson(Map<String, dynamic> json) {
    return StoryResponse(
      id: json['id'],
      storyName: json['storyName'] ?? '',
      author: json['author'] ?? '',
      sourceUrl: json['sourceUrl'] ?? '',
      site: json['site'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      active: json['active'] ?? false,
      chapterFrom: json['chapterFrom'],
      chapterTo: json['chapterTo'],
      description: json['description'] ?? '',
    );
  }
}

// 🔹 Model: ChapterResponse
class ChapterResponse {
  final int id;
  final int chapterNumber;
  final String title;
  final String content;
  final int totalChapters;

  ChapterResponse({
    required this.id,
    required this.chapterNumber,
    required this.title,
    required this.content,
    required this.totalChapters,
  });

  factory ChapterResponse.fromJson(Map<String, dynamic> json) {
    return ChapterResponse(
      id: json['id'],
      chapterNumber: json['chapterNumber'],
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      totalChapters: json['totalChapters'] ?? 0,
    );
  }
}

// 🔹 Service Class
class StoryService {
  static const String baseUrl = 'https://tktruyen.site/api';

  static Future<List<StoryResponse>> getAll() async {
    final url = Uri.parse(baseUrl);
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data.map((e) => StoryResponse.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  static Future<StoryResponse> getById(int id) async {
    final url = Uri.parse('$baseUrl/story/$id');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return StoryResponse.fromJson(json.decode(res.body));
    } else {
      throw Exception('Failed to load story $id');
    }
  }

  static Future<ChapterResponse> getChapterById(int storyId, int chapterNumber) async {
    final url = Uri.parse('$baseUrl/detail-chapter/$storyId/$chapterNumber');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return ChapterResponse.fromJson(json.decode(res.body));
    } else {
      throw Exception('Failed to load chapter');
    }
  }

  static Future<List<dynamic>> getListChapterById(int storyId, int page) async {
    final url = Uri.parse('$baseUrl/get-list-chapters?storyId=$storyId&page=$page');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return data['data'];
    } else {
      throw Exception('Failed to get list chapters');
    }
  }

  static Future<List<dynamic>> getListCategory() async {
    final url = Uri.parse('$baseUrl/categories');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<dynamic>> getListStoryByCategory(int categoryId, {int page = 1, int limit = 10}) async {
    final url = Uri.parse('$baseUrl/get-list-stories-by-categories?categoryId=$categoryId&page=$page&limit=$limit');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      throw Exception('Failed to load stories by category');
    }
  }

  static Future<List<dynamic>> getListNominatedStory() async {
    final url = Uri.parse('$baseUrl/get-list-nominated-story');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      throw Exception('Failed to load nominated stories');
    }
  }

  static Future<List<dynamic>> getListChapterNew() async {
    final url = Uri.parse('$baseUrl/get-list-chapter-new');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      throw Exception('Failed to load new chapters');
    }
  }
}
