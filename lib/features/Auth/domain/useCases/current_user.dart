import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/use%20case/use_cases.dart';
import 'package:blog_app/core/comman/entities/user.dart';
import 'package:blog_app/features/Auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class CurrentUser implements UseCases<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);
  @override
  Future<Either<Failures, User>> call(NoParams params) async {
    return await authRepository.getUser();
  }
}
