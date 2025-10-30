import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:heheheh/models/story.dart';
import 'package:heheheh/models/chapter.dart';

// 🔹 Service Class
class StoryService {
  static const String baseUrl = 'https://tktruyen.site/api';

  static Future<List<Story>> getAll() async {
    final url = Uri.parse(baseUrl);
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      return data.map((e) => Story.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load stories');
    }
  }

  static Future<Story> getById(int id) async {
    final url = Uri.parse('$baseUrl/story/$id');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return Story.fromJson(json.decode(res.body));
    } else {
      throw Exception('Failed to load story $id');
    }
  }

  static Future<Chapter> getChapterById(int storyId, int chapterNumber) async {
    final url = Uri.parse('$baseUrl/detail-chapter/$storyId/$chapterNumber');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return Chapter.fromJson(json.decode(res.body));
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

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return json.decode(res.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<Map<String, dynamic>> register(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return json.decode(res.body);
    } else {
      throw Exception('Failed to register');
    }
  }
}
