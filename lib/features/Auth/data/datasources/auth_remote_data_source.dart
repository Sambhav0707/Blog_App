import 'package:blog_app/core/error/server_exception.dart';
import 'package:blog_app/features/Auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw const ServerException("User is null");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signUp(email: email, password: password, data: {
        'name': name,
      });
      if (response.user == null) {
        throw const ServerException("User is null");
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}


// import 'dart:developer';

// import 'package:blog_app/core/error/server_exception.dart';
// import 'package:blog_app/features/Auth/data/models/user_model.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// abstract interface class AuthRemoteDataSource {
//   Future<UserModel> signUpWithEmailPassword({
//     required String name,
//     required String email,
//     required String password,
//   });
//   Future<UserModel> loginWithEmailPassword({
//     required String email,
//     required String password,
//   });
// }

// class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
//   final SupabaseClient supabaseClient;

//   AuthRemoteDataSourceImpl(this.supabaseClient);

//   @override
//   Future<UserModel> loginWithEmailPassword({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final response = await supabaseClient.auth.signInWithPassword(
//         email: email,
//         password: password,
//       );
      
//       if (response.user == null) {
//         throw const ServerException("Login failed: User is null");
//       }

//       return UserModel.fromJson(response.user!.toJson());
//     } catch (e) {
//       throw ServerException("Login failed: ${e.toString()}");
//     }
//   }

//   @override
//   Future<UserModel> signUpWithEmailPassword({
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     try {
//       // Ensure Supabase response is valid
//       final response = await supabaseClient.auth.signUp(
//         email: email,
//         password: password,
//         data: {'name': name},
//       );

//       // Check if response is valid and if user creation was successful
//       if (response.user == null) {
//         throw const ServerException("User creation failed: User is null");
//       }

//       // if (response.s != null) {
//       //   throw ServerException("User creation failed: ${response.error!.message}");
//       // }

//       // Log response for debugging
//       log("SignUp Response: ${response.user?.toJson()}");

//       // Return user model if sign-up is successful
//       return UserModel.fromJson(response.user!.toJson());
//     } catch (e) {
//       log("SignUp error: $e");
//       throw ServerException("SignUp failed: ${e.toString()}");
//     }
//   }
// }

