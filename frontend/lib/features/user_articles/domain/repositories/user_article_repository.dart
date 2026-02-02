import 'dart:io';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/entities/user_article_entity.dart';

abstract class UserArticleRepository {
  // Firestore methods
  Future<DataState<List<UserArticleEntity>>> getUserArticles();
  
  Future<DataState<void>> createArticle(UserArticleEntity article);
  
  Future<DataState<void>> updateArticle(UserArticleEntity article);
  
  Future<DataState<void>> deleteArticle(String articleId);
  
  // Storage methods
  Future<DataState<String>> uploadThumbnail(File imageFile, String articleId);
}