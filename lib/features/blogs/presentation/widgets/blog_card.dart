import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/time_calculater.dart';
import 'package:blog_app/features/blogs/domian/entities/blog.dart';
import 'package:blog_app/features/blogs/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewerPage.Route( blog));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 200,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    blog.title,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: blog.topics.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chip(
                          color: const WidgetStatePropertyAll(
                              AppPallete.backgroundColor),
                          label: Text(e),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Text(
              "${calculateTime(blog.content)} min read",
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
