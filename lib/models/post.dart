import 'dart:convert';

class Post {
  final String author;
  final String community;
  final String title;
  final String description;
  final String thumbnail;
  final int comments;
  final List<dynamic> activeVotes;
  final DateTime createdAt;
  final double payout;
  final int children;

  Post({
    required this.payout,
    required this.author,
    required this.community,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.comments,
    required this.activeVotes,
    required this.createdAt,
    required this.children,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> metadata = {};
    if (json['json_metadata'] != null) {
      try {
        metadata = json['json_metadata'] is String
            ? jsonDecode(json['json_metadata'])
            : json['json_metadata'];
      } catch (e) {
        print('Error decoding json_metadata: $e');
      }
    }
    return Post(
      author: json['author'] ?? '',
      children: json['children'] ?? 0,
      community: json['community_title'] ?? '',
      createdAt: DateTime.tryParse(json['created']) ?? DateTime.now(),
      thumbnail: json['json_metadata'] != null &&
              json['json_metadata']['image'] != null &&
              json['json_metadata']['image'].isNotEmpty
          ? json['json_metadata']['image'][0]
          : '',
      title: json['title'] ?? '',
      // description: json['body'] ?? '',
      description: metadata['description'] ?? json['body'] ?? '',
      payout: json['payout'] != null
          ? double.tryParse(json['payout'].toString()) ?? 0
          : 0,
      activeVotes: json['active_votes'] ?? [],
      comments: json['children'] ?? 0,
    );
  }
}
