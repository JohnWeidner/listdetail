class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  static List<Post> fromList(List<dynamic> json, {bool growable = false}) {
    final posts = <Post>[];
    for (final eventJson in json) {
        final event = Post.fromJson(eventJson as Map<String, dynamic>);
        posts.add(event);
    }
    return posts;
  }
}