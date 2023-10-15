part of 'blogs_bloc_bloc.dart';

sealed class BlogsBlocState extends Equatable {
  const BlogsBlocState();

  @override
  List<Object> get props => [];
}

final class BlogsBlocInitial extends BlogsBlocState {}

class BlogsBlocLoaded extends BlogsBlocState {
  final List<Blog> blogs;

  const BlogsBlocLoaded(this.blogs);

  @override
  List<Object> get props => [blogs];
}

class BlogsBlocErrorState extends BlogsBlocState {
  final String error;

  const BlogsBlocErrorState(this.error);

  @override
  List<Object> get props => [error];
}
