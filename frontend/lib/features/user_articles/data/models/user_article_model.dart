import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/entities/user_article_entity.dart';

class UserArticleModel extends UserArticleEntity {
  const UserArticleModel({
    String? id,
    String? title,
    String? author,
    String? content,
    String? thumbnailURL,
    DateTime? createdAt,
  }) : super(
          id: id,
          title: title,
          author: author,
          content: content,
          thumbnailURL: thumbnailURL,
          createdAt: createdAt,
        );

  factory UserArticleModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserArticleModel(
      id: data['id'] ?? doc.id,
      title: data['title'] ?? "",
      author: data['author'] ?? "",
      content: data['content'] ?? "",
      thumbnailURL: data['thumbnailURL'] ?? "",
      createdAt: data['createdAt'] != null 
          ? (data['createdAt'] as Timestamp).toDate() 
          : DateTime.now(),
    );
  }

  factory UserArticleModel.fromEntity(UserArticleEntity entity) {
    return UserArticleModel(
      id: entity.id,
      title: entity.title,
      author: entity.author,
      content: entity.content,
      thumbnailURL: entity.thumbnailURL,
      createdAt: entity.createdAt,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'content': content,
      'thumbnailURL': thumbnailURL,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : Timestamp.now(),
    };
  }
}