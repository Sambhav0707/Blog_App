import 'package:blog_app/core/app_secrets/supabase_app_keys.dart';
import 'package:blog_app/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/Auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/Auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/Auth/domain/useCases/user_login.dart';
import 'package:blog_app/features/Auth/domain/useCases/user_sign_up.dart';
import 'package:blog_app/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _authDependencies();

  // final supabase = await Supabase.initialize(
  //     url: SupabaseAppKeys().supabseUrl,
  //     anonKey: SupabaseAppKeys().supabaseAnonKey);

  // serviceLocator.registerLazySingleton(() => supabase.client);

  // try {
  //   final supabase = await Supabase.initialize(
  //       url: SupabaseAppKeys().supabseUrl,
  //       anonKey: SupabaseAppKeys().supabaseAnonKey);
  //   serviceLocator.registerLazySingleton(() => supabase.client);
  // } catch (e) {
  //   throw Exception("Failed to initialize Supabase: $e");
  // }
}

void _authDependencies() {
  serviceLocator
      .registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
            serviceLocator(),
          ));

  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        serviceLocator(),
      ));

  serviceLocator.registerFactory(() => UserSignUp(
        serviceLocator(),
      ));

  serviceLocator.registerFactory(() => UserLogin(
        serviceLocator(),
      ));

  serviceLocator.registerLazySingleton(() => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
      ));
}
