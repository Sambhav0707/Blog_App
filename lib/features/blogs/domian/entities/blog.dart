// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Blog {
  final String id;
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;
  final String imageUrl;
  final DateTime updatedAt;
  final String? posterName;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
    required this.imageUrl,
    required this.updatedAt,
    this.posterName,
  });
}
