import 'package:flutter/material.dart';
import 'post_widget.dart';


class HomePage extends StatelessWidget{
  final String postId;

  const HomePage({Key? key, required this.postId}) :super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        
        child: PostWidget(
          postId: 'postId', 
          content: 'post_content', 
          userId: 'userId',
          ),
    ),
    );
  }

}
