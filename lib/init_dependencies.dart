import 'package:blog_app/core/app_secrets/supabase_app_keys.dart';
import 'package:blog_app/core/comman/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/network/network_info.dart';
import 'package:blog_app/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/Auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/Auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/Auth/domain/useCases/current_user.dart';
import 'package:blog_app/features/Auth/domain/useCases/user_login.dart';
import 'package:blog_app/features/Auth/domain/useCases/user_sign_up.dart';
import 'package:blog_app/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blogs/data/data_sources/blog_remote_data_source.dart';
import 'package:blog_app/features/blogs/data/repository/blog_repository_impl.dart';
import 'package:blog_app/features/blogs/domian/repositories/blog_repository.dart';
import 'package:blog_app/features/blogs/domian/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blogs/domian/usecases/upload_blog.dart';
import 'package:blog_app/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _authDependencies();
  _blogDependencies();

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

  serviceLocator.registerFactory(() => Connectivity());

  // core
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );

  serviceLocator
      .registerFactory<NetworkInfo>(() => NetworkInfoImp(serviceLocator()));
}

void _authDependencies() {
  serviceLocator
      .registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
            serviceLocator(),
          ));

  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ));

  serviceLocator.registerFactory(() => UserSignUp(
        serviceLocator(),
      ));

  serviceLocator.registerFactory(() => UserLogin(
        serviceLocator(),
      ));

  serviceLocator.registerFactory(
    () => CurrentUser(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(() => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ));
}

_blogDependencies() {
  //remote data source implementation

  serviceLocator.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UploadBlog(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(() => GetAllBlogs(serviceLocator()));

  serviceLocator.registerLazySingleton(() => BlogBloc(
        serviceLocator(),
        serviceLocator(),
      ));
}
