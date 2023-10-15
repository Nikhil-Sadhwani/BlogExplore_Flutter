part of 'blogs_bloc_bloc.dart';

sealed class BlogsBlocEvent extends Equatable {
  const BlogsBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadBlogs extends BlogsBlocEvent {
  @override
  List<Object> get props => [];
}

class UpdateBlog extends BlogsBlocEvent {
  final Blog blog;

  const UpdateBlog({
    required this.blog,
  });

  @override
  List<Object> get props => [blog];
}
