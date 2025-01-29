part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogSuccess extends BlogState {}

final class BlogGetAllBlogSuccess extends BlogState {
  final List<Blog> blogs;

  BlogGetAllBlogSuccess(this.blogs);
}

final class BlogError extends BlogState {
  final String message;

  BlogError(this.message);
}
