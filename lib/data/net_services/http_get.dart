import 'package:http/http.dart' as http;

class HttpGet {
  HttpGet(String url) : uri = Uri.parse(url);
  final Uri uri;

  Future<http.Response> get() {
    return http.get(uri);
  }
}
