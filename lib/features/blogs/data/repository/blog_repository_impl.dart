import 'dart:developer';
import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/error/server_exception.dart';
import 'package:blog_app/features/blogs/data/data_sources/blog_remote_data_source.dart';
import 'package:blog_app/features/blogs/data/models/blog_model.dart';
import 'package:blog_app/features/blogs/domian/entities/blog.dart';
import 'package:blog_app/features/blogs/domian/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl(this.blogRemoteDataSource);

  @override
  Future<Either<Failures, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        title: title,
        content: content,
        posterId: posterId,
        topics: topics,
        imageUrl: '',
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadImage(
        image,
        blogModel,
      );

      blogModel = blogModel.copyWith(
        imageUrl: imageUrl,
      );

      final blog = await blogRemoteDataSource.uploadBlog(
        blogModel,
      );

      return Right(blog);
    } on ServerException catch (e) {
      log(e.message);
      return Left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, List<Blog>>> getBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();
      return Right(blogs);
    } on ServerException catch (e) {
      log(e.message);
      return Left(Failures(e.message));
    }
  }
}
