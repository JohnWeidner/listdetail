import 'package:flutter/material.dart';
import 'package:listdetail/post.dart';

class DetailView extends StatelessWidget {
  final Post post;

  const DetailView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(post.body),
          ],
        ),
      ),
    );
  }
}