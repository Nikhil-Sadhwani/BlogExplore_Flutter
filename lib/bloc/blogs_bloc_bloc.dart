import 'package:bloc/bloc.dart';
import 'package:blog_explore/models/blog_model.dart';
import 'package:blog_explore/repos/repository.dart';
import 'package:equatable/equatable.dart';

part 'blogs_bloc_event.dart';
part 'blogs_bloc_state.dart';

class BlogsBlocBloc extends Bloc<BlogsBlocEvent, BlogsBlocState> {
  final BlogsRepository _blogsRepository;

  BlogsBlocBloc(this._blogsRepository) : super(BlogsBlocInitial()) {
    on<LoadBlogs>(_onLoadBlogs);
    on<UpdateBlog>(_onUpdateBlog);
  }

  void _onLoadBlogs(LoadBlogs event, Emitter<BlogsBlocState> emit) async {
    emit(BlogsBlocInitial());
    try {
      final List<Blog> blogs = await _blogsRepository.getBlogs();
      emit(
        BlogsBlocLoaded(blogs),
      );
    } catch (e) {
      emit(BlogsBlocErrorState(e.toString()));
    }
  }

  void _onUpdateBlog(UpdateBlog event, Emitter<BlogsBlocState> emit) {
    final state = this.state;
    if (state is BlogsBlocLoaded) {
      List<Blog> blogs = (state.blogs.map((e) {
        return e.id == event.blog.id ? event.blog : e;
      })).toList();
      emit(BlogsBlocLoaded(blogs));
    }
  }
}
