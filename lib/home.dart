import 'package:blog_explore/bloc/blogs_bloc_bloc.dart';
import 'package:blog_explore/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogsBlocBloc, BlogsBlocState>(
      builder: (context, state) {
        if (state is BlogsBlocInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is BlogsBlocLoaded) {
          return ListView.builder(
            itemCount: state.blogs.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 80,
                  color: Colors.blue.shade200,
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(5.0),
                  child: ListTile(
                    leading: SizedBox(
                        width: 100,
                        child: Image.network(
                          state.blogs[index].imageUrl,
                          fit: BoxFit.cover,
                        )),
                    title: Text(state.blogs[index].title),
                    onTap: () {
                      // Navigate to the detailed blog view
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return BlogDetail(blogid: state.blogs[index].id);
                      }));
                    },
                  ));
            },
          );
        } else if (state is BlogsBlocErrorState) {
          return const Center(child: Text("Network issue"));
        } else {
          return const Center(child: Text("Something Went Wrong !"));
        }
      },
    );
  }
}
