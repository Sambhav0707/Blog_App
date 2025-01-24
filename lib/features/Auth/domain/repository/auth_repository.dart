import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/Auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failures, User>> signInWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

   Future<Either<Failures, User>> loginInWithEmailPassword({
 
    required String email,
    required String password,
  });
}
