import 'dart:io';

import 'package:blog_app/core/use%20case/use_cases.dart';
import 'package:blog_app/features/blogs/domian/entities/blog.dart';
import 'package:blog_app/features/blogs/domian/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blogs/domian/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  final GetAllBlogs getAllBlogs;
  BlogBloc(
    this.uploadBlog,
    this.getAllBlogs,
  ) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => BlogLoading());

    on<BlogUploadEvent>(_uploadBlog);

    on<BlogGetAllBLogsEvent>(_getBlogs);
  }

  void _getBlogs(BlogGetAllBLogsEvent event, Emitter<BlogState> emit) async {
    final blogs = await getAllBlogs.call(NoParams());

    blogs.fold((failure) {
      emit(BlogError(failure.message));
    }, (success) {
      emit(BlogGetAllBlogSuccess(success));
    });
  }

  void _uploadBlog(BlogUploadEvent event, Emitter<BlogState> emit) async {
    final res = await uploadBlog.call(UploadBlogParams(
      event.title,
      event.content,
      event.posterId,
      event.topics,
      event.image,
    ));

    return res.fold(
      (failure) {
        emit(BlogError(failure.message));
      },
      (blog) {
        emit(BlogSuccess());
      },
    );
  }
}
