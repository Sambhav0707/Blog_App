import 'dart:developer';

import 'package:blog_app/core/comman/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/use%20case/use_cases.dart';
import 'package:blog_app/features/Auth/domain/useCases/current_user.dart';
import 'package:blog_app/features/Auth/domain/useCases/user_login.dart';
import 'package:blog_app/features/Auth/domain/useCases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/comman/entities/user.dart';

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
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>(
      (_, emit) => AuthLoading(),
    );
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLoginIn>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
  }

  void _onAuthIsUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emmitAuthSuccess(r, emit),
    );
  }

  void _onAuthLogin(AuthLoginIn event, Emitter<AuthState> emit) async {
    // emit(AuthLoading());
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
      (user) => _emmitAuthSuccess(user, emit),
    );
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    // emit(AuthLoading());
    final res = await _userSignUp(
      UserSignUpParams(event.email, event.password, event.name),
    );

    log("SignUp Response: $res");

    res.fold(
      (failure) {
        log("SignUp Failed: ${failure.message}");
        emit(AuthFailure(failure.message));
      },
      (user) => _emmitAuthSuccess(user, emit),
    );
  }

  void _emmitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
