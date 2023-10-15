import 'package:blog_explore/bloc/blogs_bloc_bloc.dart';
import 'package:blog_explore/models/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogDetail extends StatefulWidget {
  const BlogDetail({super.key, required this.blogid});
  final String blogid;
  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  late String data = widget.blogid;
  late Blog blogs;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogsBlocBloc, BlogsBlocState>(
      builder: (context, state) {
        if (state is BlogsBlocInitial) {
          return const CircularProgressIndicator();
        }
        if (state is BlogsBlocLoaded) {
          for (var element in state.blogs) {
            if (element.id == data) {
              blogs = element;
            }
          }
          return Scaffold(
              appBar: AppBar(
                title: const Text('Blog Deatil'),
                actions: [
                  IconButton(
                      onPressed: () {
                        if (blogs.isFav == true) {
                          context.read<BlogsBlocBloc>().add(
                                UpdateBlog(
                                  blog: blogs.copyWith(isFav: false),
                                ),
                              );
                        } else {
                          context.read<BlogsBlocBloc>().add(
                                UpdateBlog(
                                  blog: blogs.copyWith(isFav: true),
                                ),
                              );
                        }
                      },
                      icon: Icon(blogs.isFav == true
                          ? Icons.star
                          : Icons.star_border)),
                ],
              ),
              body: Column(children: [
                SizedBox(
                    width: double.infinity,
                    child: Image.network(
                      blogs.imageUrl,
                      fit: BoxFit.cover,
                    )),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Text(
                    blogs.title,
                    style: const TextStyle(fontSize: 20),
                  ),
                )
              ]));
        } else if (state is BlogsBlocErrorState) {
          return const Center(child: Text("Network issue"));
        } else {
          return const Center(child: Text("Something Went Wrong !"));
        }
      },
    );
  }
}
