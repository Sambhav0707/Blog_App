import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/use%20case/use_cases.dart';
import 'package:blog_app/features/blogs/domian/entities/blog.dart';
import 'package:blog_app/features/blogs/domian/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class GetAllBlogs implements UseCases<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failures, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getBlogs();
  }
}
