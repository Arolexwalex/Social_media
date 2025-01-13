import 'package:flutter/material.dart';
import 'comment.dart';
import 'profile_manager.dart';
import 'comment_widget.dart';

class CommentsList extends StatefulWidget {
  final String postId;

  const CommentsList({Key? key, required this.postId}) : super(key: key);

  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  final ProfileManager _profileManager = ProfileManager();
  List<Comment>? _comments;

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
  try {
    final comments = await _profileManager.getComments(widget.postId);
    print('Fetched comments: ${comments.length}'); // Add this line
    setState(() {
      _comments = comments;
    });
  } catch (e) {
    print(e);
  }
}


@override
Widget build(BuildContext context) {
  return _comments != null
      ? ListView.builder(
          shrinkWrap: true,
          itemCount: _comments!.length,
          itemBuilder: (context, index) {
            return CommentWidget(comment: _comments![index]);
          },
        )
      : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading comments...'),
            ],
          ),
        );
}
}