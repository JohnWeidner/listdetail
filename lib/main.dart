import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:listdetail/detail_view.dart';
import 'package:listdetail/post.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON Data Reader',
      routes: {
        '/detail': (context) => DetailView( post: Post( id: 0, title: 'title', body: 'body') ),
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late Future<List<Post>> _posts;

  @override
  void initState() {
    super.initState();
    _posts = _fetchPosts();
  }

  Future<List<Post>> _fetchPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      // If the server returned a 200 OK response,
      // then parse the JSON body into a list of Post objects.
      final  posts = Post.fromList( jsonDecode(response.body) );
      return posts;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to fetch posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( body:
    LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Tablet layout
          return Row(
            children: <Widget>[
              Expanded(child: _buildListView()),
              Expanded(child: _buildDetailView()),
            ],
          );
        } else {
          // Phone layout
          return _buildListView();
        }
      },
    ),);
  }

  Widget _buildListView() {
    return FutureBuilder(
      future: _posts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final post = snapshot.data![index];
              return ListTile(
                title: Text(post.title),
                onTap: () {
                  // Navigate to the detail view.
                  Navigator.pushNamed(context, '/detail', arguments: post);
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildDetailView() {
    return DetailView(post: Post( id: 0, title: 'title2', body: 'body2',), );
  }
}

void main() {
  runApp(const MyApp());
}