import 'dart:developer';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/error/server_exception.dart';
import 'package:blog_app/core/network/network_info.dart';
import 'package:blog_app/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/core/comman/entities/user.dart';
import 'package:blog_app/features/Auth/data/models/user_model.dart';
import 'package:blog_app/features/Auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(this.authRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failures, User>> getUser() async {
    try {
      if (!await (networkInfo.isConnected())) {
        final session = authRemoteDataSource.currentUserSession;

        if (session == null) {
          return Left(Failures("User not logged In"));
        }
        return Right(UserModel(
          id: session.user.id,
          email: session.user.email ?? "",
          name: "",
        ));
      }
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user != null) {
        return Right(user);
      } else {
        return Left(Failures("User not found"));
      }
    } on ServerException catch (e) {
      return Left(Failures(e.message));
    }
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
      if (!await (networkInfo.isConnected())) {
        log("no iternet");
        return Left(Failures("No Internet Connection"));
      }
      final user = await fn();

      return Right(user);
    } on sb.AuthException catch (e) {
      return Left(Failures(e.message));
    } on ServerException catch (e) {
      return Left(Failures(e.message));
    }
  }
}
