import 'package:flutter/material.dart';
import '../models/post.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({super.key, required this.post});
  String _extractDescription(String description) {
    // Strip any unwanted Markdown or HTML tags (basic example).
    return description
        .replaceAll(RegExp(r'\[.*?\]\(.*?\)'), '')
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(
                            'https://images.hive.blog/u/${post.author}/avatar'),
                        onBackgroundImageError: (_, __) =>
                            const Icon(Icons.person),
                      ),
                      SizedBox(width: 5.0),
                      Row(
                        children: [
                          Text(
                            post.author,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Text(" (${post.children.toString()})"),
                        ],
                      ),
                      Text(
                        ' in ${post.community}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Icon(
                    Icons.circle,
                    size: 5,
                    color: Colors.grey.shade600,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    timeago.format(post.createdAt),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Check for thumbnail URL validity.
            post.thumbnail.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(
                      post.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 50);
                      },
                    ),
                  )
                : const Icon(Icons.image, size: 50),
            const SizedBox(height: 8),
            Text(
              post.title.trim(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              _extractDescription(post.description),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: Colors.red.shade600,
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded),
                    SizedBox(width: 4.0),
                    Text("\$${post.payout.toStringAsFixed(2)}"),
                    Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: 16.0,
                      color: Colors.grey.shade400,
                    ),
                    Text('${post.activeVotes.length}'),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.messenger,
                      size: 16.0,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 4.0),
                    Text('${post.comments}'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Icon(
                    Icons.turn_right_sharp,
                    color: Colors.grey.shade600,
                    size: 20.0,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
