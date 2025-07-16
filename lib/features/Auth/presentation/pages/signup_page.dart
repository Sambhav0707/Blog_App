import 'package:blog_app/core/comman/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/Auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/Auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/Auth/presentation/widgets/auth_field_button.dart';
import 'package:blog_app/features/blogs/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  static Route() => MaterialPageRoute(
        builder: (context) => LoginPage(),
      );

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              return showSnackBar(context, state.message);
            } else if (state is AuthSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                BlogPage.Route(),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        'Sign up.',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AuthField(
                      hintText: 'name',
                      controller: nameController,
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
                          context.read<AuthBloc>().add(AuthSignUp(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                nameController.text.trim(),
                              ));
                        }
                      },
                      buttonText: 'Sign Up',
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
                              text: 'Already have an Account?  ',
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                            TextSpan(
                              text: 'Sign In',
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
              ),
            );
          },
        ),
      ),
    );
  }
}
