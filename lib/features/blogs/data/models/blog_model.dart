import 'package:blog_app/features/blogs/domian/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.title,
    required super.content,
    required super.posterId,
    required super.topics,
    required super.imageUrl,
    required super.updatedAt,
    super.posterName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'poster_id': posterId,
      'topics': topics,
      'image_url': imageUrl,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      posterId: map['poster_id'] as String,
      topics: List<String>.from(map['topics'] ?? []),
      imageUrl: map['image_url'] as String,
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
    );
  }

   BlogModel copyWith({
    String? id,
    String? title,
    String? content,
    String? posterId,
    List<String>? topics,
    String? imageUrl,
    DateTime? updatedAt,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      posterId: posterId ?? this.posterId,
      topics: topics ?? this.topics,
      imageUrl: imageUrl ?? this.imageUrl,
      updatedAt: updatedAt ?? this.updatedAt,
      posterName: posterName ?? this.posterName,
    );
  }
}
