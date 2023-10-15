import 'package:blog_explore/bloc/blogs_bloc_bloc.dart';
import 'package:blog_explore/favorite.dart';
import 'package:blog_explore/home.dart';
import 'package:blog_explore/repos/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 0;
  List<Widget> pages = const [HomePage(), FavoriteBlogs()];
  List<String> titleName = const ["Home", "Favorite"];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => BlogsRepository(),
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => BlogsBlocBloc(
                RepositoryProvider.of<BlogsRepository>(context),
              )..add(LoadBlogs()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                title: Text(titleName[currentPage]),
              ),
              body: pages[currentPage],
              bottomNavigationBar: NavigationBar(
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.home), label: "Home"),
                  NavigationDestination(
                      icon: Icon(Icons.star_border), label: "Favorite")
                ],
                onDestinationSelected: (int index) {
                  setState(
                    () {
                      currentPage = index;
                    },
                  );
                },
                selectedIndex: currentPage,
              ),
            ),
          )),
    );
  }
}
