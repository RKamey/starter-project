import 'dart:io';
import 'package:dio/dio.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/user_articles/data/data_sources/user_article_firebase_data_source.dart';
import 'package:news_app_clean_architecture/features/user_articles/data/models/user_article_model.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/entities/user_article_entity.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/repositories/user_article_repository.dart';

class UserArticleRepositoryImpl implements UserArticleRepository {
  final UserArticleFirebaseDataSource _firebaseDataSource;

  UserArticleRepositoryImpl(this._firebaseDataSource);

  @override
  Future<DataState<List<UserArticleEntity>>> getUserArticles() async {
    try {
      final articles = await _firebaseDataSource.getUserArticles();
      return DataSuccess(articles);
    } catch (e) {
      return DataFailed(
        DioError(
          error: e.toString(),
          type: DioErrorType.other,
          requestOptions: RequestOptions(path: ''),
        ),
      );
    }
  }

  @override
  Future<DataState<void>> createArticle(UserArticleEntity article) async {
    try {
      await _firebaseDataSource.createArticle(
        UserArticleModel.fromEntity(article),
      );
      return const DataSuccess(null);
    } catch (e) {
      return DataFailed(
        DioError(
          error: e.toString(),
          type: DioErrorType.other,
          requestOptions: RequestOptions(path: ''),
        ),
      );
    }
  }

  @override
  Future<DataState<void>> updateArticle(UserArticleEntity article) async {
    try {
      await _firebaseDataSource.updateArticle(
        UserArticleModel.fromEntity(article),
      );
      return const DataSuccess(null);
    } catch (e) {
      return DataFailed(
        DioError(
          error: e.toString(),
          type: DioErrorType.other,
          requestOptions: RequestOptions(path: ''),
        ),
      );
    }
  }

  @override
  Future<DataState<void>> deleteArticle(String articleId) async {
    try {
      await _firebaseDataSource.deleteArticle(articleId);
      return const DataSuccess(null);
    } catch (e) {
      return DataFailed(
        DioError(
          error: e.toString(),
          type: DioErrorType.other,
          requestOptions: RequestOptions(path: ''),
        ),
      );
    }
  }

  @override
  Future<DataState<String>> uploadThumbnail(File imageFile, String articleId) async {
    try {
      final thumbnailURL = await _firebaseDataSource.uploadThumbnail(imageFile, articleId);
      return DataSuccess(thumbnailURL);
    } catch (e) {
      return DataFailed(
        DioError(
          error: e.toString(),
          type: DioErrorType.other,
          requestOptions: RequestOptions(path: ''),
        ),
      );
    }
  }
}
