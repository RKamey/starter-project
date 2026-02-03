import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:news_app_clean_architecture/features/user_articles/data/models/user_article_model.dart';

abstract class UserArticleFirebaseDataSource {
  Future<List<UserArticleModel>> getUserArticles();
  Future<void> createArticle(UserArticleModel article);
  Future<void> updateArticle(UserArticleModel article);
  Future<void> deleteArticle(String articleId);
  Future<String> uploadThumbnail(File imageFile, String articleId);
}

class UserArticleFirebaseDataSourceImpl implements UserArticleFirebaseDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  UserArticleFirebaseDataSourceImpl(this._firestore, this._storage);

  @override
  Future<List<UserArticleModel>> getUserArticles() async {
    try {
      final querySnapshot = await _firestore
          .collection('articles')
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => UserArticleModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get articles: $e');
    }
  }

  @override
  Future<void> createArticle(UserArticleModel article) async {
    try {
      final docRef = _firestore.collection('articles').doc(article.id);
      await docRef.set(article.toFirestore());
    } catch (e) {
      throw Exception('Failed to create article: $e');
    }
  }

  @override
  Future<void> updateArticle(UserArticleModel article) async {
    try {
      await _firestore
          .collection('articles')
          .doc(article.id)
          .update(article.toFirestore());
    } catch (e) {
      throw Exception('Failed to update article: $e');
    }
  }

  @override
  Future<void> deleteArticle(String articleId) async {
    try {
      await _firestore.collection('articles').doc(articleId).delete();

      try {
        await _storage.ref('media/articles/$articleId.jpg').delete();
      } catch (e) {
        // If thumbnail doesn't exist, continue
      }
    } catch (e) {
      throw Exception('Failed to delete article: $e');
    }
  }

  @override
  Future<String> uploadThumbnail(File imageFile, String articleId) async {
    try {
      final storageRef = _storage.ref('media/articles/$articleId.jpg');

      final uploadTask = storageRef.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      await uploadTask;

      final downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    } catch (e) {
      throw Exception('Failed to upload thumbnail: $e');
    }
  }
}
