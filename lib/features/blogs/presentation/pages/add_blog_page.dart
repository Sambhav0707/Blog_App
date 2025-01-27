import 'dart:io';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/features/blogs/presentation/widgets/blog_fied.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            image != null
                ? GestureDetector(
                    onTap: () {
                      selectImage();
                    },
                    child: Image.file(
                      image!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
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
                        height: 200,
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
                            ? WidgetStatePropertyAll(AppPallete.gradient1)
                            : null,
                        label: Text(e),
                      ),
                    ),
                  );
                }).toList(),
              ),
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
    );
  }
}
