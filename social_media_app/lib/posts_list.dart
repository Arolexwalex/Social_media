import 'package:flutter/material.dart';
import 'package:social_media_app/post_widget.dart';
import 'package:social_media_app/profile_manager.dart';
import 'post.dart';


class PostsList extends StatefulWidget {
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final ProfileManager _profileManager = ProfileManager();
  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    final fetchedPosts = await _profileManager.getPosts();
    setState(() {
      _posts = fetchedPosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _posts.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _posts.length,
            itemBuilder: (context, index) {
              return PostWidget(
                postId: _posts[index].postId,
                content: _posts[index].content,
                userId: _posts[index].userId,
              );
            },
          );
  }
}

