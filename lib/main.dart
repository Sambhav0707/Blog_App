import 'package:blog_app/core/app_secrets/supabase_app_keys.dart';
import 'package:blog_app/core/comman/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/Auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/Auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/Auth/domain/useCases/user_sign_up.dart';
import 'package:blog_app/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/Auth/presentation/pages/login_page.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  try {
    final supabase = await Supabase.initialize(
        url: SupabaseAppKeys().supabseUrl,
        anonKey: SupabaseAppKeys().supabaseAnonKey);
    serviceLocator.registerLazySingleton(() => supabase.client);
  } catch (e) {
    throw Exception("Failed to initialize Supabase: $e");
  }
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLOG APP',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const Scaffold(
              body: Center(
                child: Text("logged in"),
              ),
            );
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
