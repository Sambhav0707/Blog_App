import 'package:blog_app/core/comman/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/Auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/Auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/Auth/presentation/widgets/auth_field_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static Route() => MaterialPageRoute(
        builder: (context) => SignupPage(),
      );
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              return showSnackBar(context , state.message);
            }
           
          },
          builder: (context, state) {
              if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      'Sign in.',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthField(
                    hintText: 'email',
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthField(
                    hintText: 'password',
                    controller: passwordController,
                    isObscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthFieldButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthLoginIn(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                    buttonText: 'Sign In',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, Route());
                    },
                    child: RichText(
                        text: TextSpan(
                            text: 'Don\'t have an Account?  ',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: AppPallete.gradient1,
                                    fontWeight: FontWeight.bold),
                          )
                        ])),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
