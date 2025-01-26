import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/use%20case/use_cases.dart';
import 'package:blog_app/core/comman/entities/user.dart';
import 'package:blog_app/features/Auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserLogin implements UseCases<User, UserLoginParams> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);
  @override
  Future<Either<Failures, User>> call(UserLoginParams params) async {
    // TODO: implement call
    return await authRepository.loginInWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams(this.email, this.password);
}
