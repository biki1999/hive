import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiService {
  static const String apiUrl = 'https://api.hive.blog/';

  static Future<List<Post>> fetchPosts() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "id": 1,
        "jsonrpc": "2.0",
        "method": "bridge.get_ranked_posts",
        "params": {"sort": "trending", "tag": "", "observer": "hive.blog"}
      }),
    );
    print('+++++++++++++++++Response${response.body}');
    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['result'];
      return results.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch posts');
    }
  }
}
