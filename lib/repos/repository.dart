import 'dart:convert';

import 'package:blog_explore/models/blog_model.dart';
import 'package:http/http.dart' as http;

class BlogsRepository {
  Future<List<Blog>> getBlogs() async {
    final response = await http.get(
        Uri.parse('https://intent-kit-16.hasura.app/api/rest/blogs'),
        headers: {
          'x-hasura-admin-secret':
              '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6',
        });

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body)['blogs'];
      List<Blog> bloglist = data.map((blog) => Blog.fromJson(blog)).toList();

      return bloglist;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
