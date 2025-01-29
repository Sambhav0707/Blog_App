import 'package:blog_app/core/utils/calculating_date_time.dart';
import 'package:blog_app/features/blogs/domian/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  static Route(Blog blog) => MaterialPageRoute(
      builder: (context) => BlogViewerPage(
            blog: blog,
          ));
  final Blog blog;
   BlogViewerPage({super.key, required this.blog});


  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "By:- ${blog.posterName!}",
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${calculateTimeInddmmmyyy(blog.updatedAt)}",
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(blog.imageUrl),
                ),
                const SizedBox(height: 20),
                Text(
                  blog.content,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 2,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
