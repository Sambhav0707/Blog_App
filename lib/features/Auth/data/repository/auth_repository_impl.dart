import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/error/server_exception.dart';
import 'package:blog_app/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/core/comman/entities/user.dart';
import 'package:blog_app/features/Auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failures, User>> getUser() async {
    try {
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user != null) {
        return Right(user);
      } else {
        return Left(Failures("User not found"));
      }
    } on ServerException catch (e) {
      return Left(Failures(e.message));
    }
    // TODO: implement getUser
  }

  @override
  Future<Either<Failures, User>> loginInWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(
        () async => await authRemoteDataSource.loginWithEmailPassword(
              email: email,
              password: password,
            ));
  }

  @override
  Future<Either<Failures, User>> signInWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(
        () async => await authRemoteDataSource.signUpWithEmailPassword(
              name: name,
              email: email,
              password: password,
            ));
  }

  Future<Either<Failures, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();

      return Right(user);
    } on sb.AuthException catch (e) {
      return Left(Failures(e.message));
    } on ServerException catch (e) {
      return Left(Failures(e.message));
    }
  }
}
