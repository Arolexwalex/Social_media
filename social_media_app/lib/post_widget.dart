import 'package:flutter/material.dart';
import 'package:social_media_app/comments_list.dart';
import 'profile_manager.dart';



class PostWidget extends StatefulWidget {
  final String postId;
  final String content;
  final String userId;

  // ignore: use_super_parameters
  const PostWidget({
    Key? key,
    required this.postId,
    required this.content,
    required this.userId,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Post ID: ${widget.postId}',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 8),
            Text(widget.content),
            SizedBox(height: 8),
            Text('Posted by: ${widget.userId}'),
            SizedBox(height: 16),
            CommentsList(postId: widget.postId),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(hintText: 'Add a comment...'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final commentContent = _commentController.text;
                await ProfileManager().createComment(widget.postId, commentContent);
                _commentController.clear();
              },
              child: Text('Comment'),
            ),
          ],
        ),
      ),
    );
  }
}


