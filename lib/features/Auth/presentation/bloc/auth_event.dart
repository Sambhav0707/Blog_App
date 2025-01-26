part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;

  AuthSignUp(this.email, this.password, this.name);
}

final class AuthLoginIn extends AuthEvent {
  final String email;
  final String password;

  AuthLoginIn(this.email, this.password);
}

final class AuthIsUserLoggedIn extends AuthEvent {}
