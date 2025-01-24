import 'dart:developer';

import 'package:blog_app/features/Auth/domain/useCases/user_login.dart';
import 'package:blog_app/features/Auth/domain/useCases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final UserSignUp _userSignUp;
//   final UserLogin _userLogin;

//   AuthBloc({
//     required UserSignUp userSignUp,
//     required UserLogin userLogin,
//   })  : _userSignUp = userSignUp,
//         _userLogin = userLogin,
//         super(AuthInitial()) {
//     on<AuthSignUp>(_onAuthSignUp);
//     on<AuthLoginIn>(_onAuthLogin);
//   }

//   void _onAuthLogin(AuthLoginIn event, Emitter<AuthState> emit) async {
//     (event, emit) async {
//       emit(AuthLoading());
//       final res = await _userLogin(
//         UserLoginParams(
//           event.email,
//           event.password,
//         ),
//       );
//       log("");

//       res.fold(
//         (failure) {
//           log("Login Failed: ${failure.message}");
//           emit(AuthFailure(failure.message));
//         },
//         (user) {
//           log("LOgged Success: User ID is $user");
//           emit(AuthSuccess(user));
//         },
//       );
//     };
//   }

//   void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
//     (event, emit) async {
//       emit(AuthLoading());
//       final res = await _userSignUp(
//         UserSignUpParams(event.email, event.password, event.name),
//       );
//       log("");

//       res.fold(
//         (failure) {
//           log("SignUp Failed: ${failure.message}");
//           emit(AuthFailure(failure.message));
//         },
//         (user) {
//           log("SignUp Success: User ID is $user");
//           emit(AuthSuccess(user));
//         },
//       );
//     };
//   }
// }

// import 'dart:developer';

// import 'package:blog_app/features/Auth/domain/useCases/user_login.dart';
// import 'package:blog_app/features/Auth/domain/useCases/user_sign_up.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../domain/entities/user.dart';

// part 'auth_event.dart';
// part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLoginIn>(_onAuthLogin);
  }

  void _onAuthLogin(AuthLoginIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin(
      UserLoginParams(
        event.email,
        event.password,
      ),
    );

    log("Login Response: $res");

    res.fold(
      (failure) {
        log("Login Failed: ${failure.message}");
        emit(AuthFailure(failure.message));
      },
      (user) {
        log("Login Success: User ID is $user");
        emit(AuthSuccess(user));
      },
    );
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
      UserSignUpParams(event.email, event.password, event.name),
    );

    log("SignUp Response: $res");

    res.fold(
      (failure) {
        log("SignUp Failed: ${failure.message}");
        emit(AuthFailure(failure.message));
      },
      (user) {
        log("SignUp Success: User ID is $user");
        emit(AuthSuccess(user));
      },
    );
  }
}

