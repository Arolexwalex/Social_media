import 'package:flutter/material.dart';
import 'profile_manager.dart';


class PostInputField extends StatefulWidget {
  @override
  _PostInputFieldState createState() => _PostInputFieldState();
}

class _PostInputFieldState extends State<PostInputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'What\'s on your mind?'),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            final postContent = _controller.text;
            await ProfileManager().createPost(postContent);
            _controller.clear();
          },
          child: Text('Post'),
           ),
      ],
    );
  }
}

