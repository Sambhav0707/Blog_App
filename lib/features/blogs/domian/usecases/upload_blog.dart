import 'dart:io';

import 'package:blog_app/features/blogs/domian/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use case/use_cases.dart';
import '../entities/blog.dart';

class UploadBlog implements UseCases<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failures, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;
  final File image;

  UploadBlogParams(
    this.title,
    this.content,
    this.posterId,
    this.topics,
    this.image,
  );
}
