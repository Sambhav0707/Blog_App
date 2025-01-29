import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blogs/presentation/pages/add_blog_page.dart';
import 'package:blog_app/features/blogs/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static Route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<BlogBloc>().add(BlogGetAllBLogsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                AddBlogPage.Route(),
              );
            },
            icon: Icon(CupertinoIcons.add_circled),
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogError) {
            return showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is BlogGetAllBlogSuccess) {
            return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  return BlogCard(
                    blog: state.blogs[index],
                    color: index % 2 == 0
                        ? AppPallete.gradient1
                        : AppPallete.gradient3,
                  );
                });
          }
          return const SizedBox(
            child: Text("No Blogs"),
          );
        },
      ),
    );
  }
}
