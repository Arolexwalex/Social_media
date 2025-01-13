import 'package:firebase_database/firebase_database.dart';
import 'post.dart';
import 'comment.dart';

class ProfileManager {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<void> createUserProfile(String userId, String name, String email) async {
    // Create a new user profile node in the database
    await _database.ref('users/$userId').set({
      'name': name,
      'email': email,
    });
  }

Future<DataSnapshot?> getUserProfile(String userId) async {
    // Get the user profile node from the database
    DataSnapshot snapshot = await _database.ref('users/$userId').get();
    // Return the user profile data
    return snapshot;
  }

  Future<void> createPost(String postContent) async {
    final userId = 'current_user_id'; // Replace with the current user's ID
    final postId = DateTime.now().millisecondsSinceEpoch.toString();
    await _database.ref('posts/$postId').set({
      'content': postContent,
      'userId': userId,
    });
  }

  Future<List<Post>> getPosts() async {
    final postsRef = _database.ref('posts');
    final postsSnapshot = await postsRef.get();
    final posts = <Post>[];

    if (postsSnapshot.exists) {
      final postsData = postsSnapshot.value as Map<dynamic, dynamic>;
      postsData.forEach((postId, postValue) {
        final post = Post(
          postId: postId,
          content: postValue['content'],
          userId: postValue['userId'],
        );
        posts.add(post);
      });
    }

    return posts;
  }


 Future<List<Comment>> getComments(String postId) async {
    final commentsRef = _database.ref('comments/$postId');
    final commentsSnapshot = await commentsRef.get();
    final comments = <Comment>[];

    if (commentsSnapshot.exists) {
      final commentsData = commentsSnapshot.value as Map<dynamic, dynamic>;
      commentsData.forEach((commentId, commentValue) {
        final comment = Comment(
          commentId: commentId,
          postId: postId,
          userId: commentValue['userId'],
          content: commentValue['content'],
        );
        comments.add(comment);
      });
    }

    return comments;
  }

  Future<void> createComment(String postId, String content) async {
    final commentId = DateTime.now().millisecondsSinceEpoch.toString();
    final userId = 'current_user_id'; // Replace with the current user's ID
    await _database.ref('comments/$postId/$commentId').set({
      'userId': userId,
      'content': content,
    });
  }





  // Add more methods to update and delete user profiles
}
