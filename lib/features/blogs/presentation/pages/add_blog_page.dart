import 'dart:io';

import 'package:blog_app/core/comman/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/comman/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blogs/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blogs/presentation/widgets/blog_fied.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBlogPage extends StatefulWidget {
  static Route() =>
      MaterialPageRoute(builder: (context) => const AddBlogPage());
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final List<String> selectedCat = [];
  File? image;

  void selectImage() async {
    File? pickedImage;

    pickedImage = await pickImage();

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  void submitBlog() {
    if (formKey.currentState!.validate() && selectedCat.isNotEmpty) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;

      context.read<BlogBloc>().add(BlogUploadEvent(
          title: controller.text,
          content: controller2.text,
          image: image!,
          topics: selectedCat,
          posterId: posterId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              submitBlog();
            },
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogError) {
            return showSnackBar(context, state.message);
          } else if (state is BlogSuccess) {
            Navigator.pushAndRemoveUntil(
                context, BlogPage.Route(), (route) => false);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                image!,
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              color: AppPallete.borderColor,
                              radius: const Radius.circular(12),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              child: const SizedBox(
                                height: 300,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_outlined,
                                      size: 35,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Add Image',
                                      style: TextStyle(
                                          color: AppPallete.whiteColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          "Presentation",
                          "Technology",
                          "Programing",
                          "General"
                        ].map((e) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                if (selectedCat.contains(e)) {
                                  selectedCat.remove(e);
                                  debugPrint(selectedCat.toString());
                                } else {
                                  selectedCat.add(e);
                                  debugPrint(selectedCat.toString());
                                }
                                setState(() {});
                              },
                              child: Chip(
                                color: selectedCat.contains(e)
                                    ? const WidgetStatePropertyAll(
                                        AppPallete.gradient1)
                                    : null,
                                label: Text(e),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlogField(
                      controller: controller,
                      hintText: "Blog Title",
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    BlogField(
                      controller: controller2,
                      hintText: "Blog Description",
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
