import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/use%20case/use_cases.dart';
import 'package:blog_app/features/Auth/domain/entities/user.dart';
import 'package:blog_app/features/Auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserSignUp implements UseCases<User, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);
  @override
  Future<Either<Failures, User>> call(UserSignUpParams params) async {
    return await authRepository.signInWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams(this.email, this.password, this.name);
}
