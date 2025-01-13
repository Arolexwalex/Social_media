import 'package:flutter/material.dart';
import 'comment.dart';


class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
         children: [
          Text(comment.userId),
          SizedBox(width: 8),
          Text(comment.content),
        ],
      ),
    );
  }
}



      
     


