import 'package:blog_app/features/blogs/data/models/blog_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadBlogs({required List<BlogModel> blogs});

  List<BlogModel> getBlogs();
}

class BlogLocalDataSourceImp implements BlogLocalDataSource {
  final Box box;

  BlogLocalDataSourceImp(this.box);
  @override
  List<BlogModel> getBlogs() {
    try {
      List<BlogModel> blogs = [];
      box.read(() {
        for (int i = 0; i < box.length; i++) {
          blogs.add(BlogModel.fromJson(box.get(i.toString())));
        }
      });

      return blogs;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  @override
  void uploadBlogs({required List<BlogModel> blogs}) {
    try {
      box.clear();
      box.write(() {
        for (int i = 0; i < blogs.length; i++) {
          box.put(i.toString(), blogs[i].toJson());
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
