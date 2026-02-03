import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/entities/user_article_entity.dart';

abstract class UserArticlesState extends Equatable {
  const UserArticlesState();

  @override
  List<Object> get props => [];
}

class UserArticlesLoading extends UserArticlesState {
  const UserArticlesLoading();
}

class UserArticlesDone extends UserArticlesState {
  final List<UserArticleEntity>? articles;

  const UserArticlesDone(this.articles);

  @override
  List<Object> get props => [articles!];
}

class UserArticlesError extends UserArticlesState {
  final DioError? error;

  const UserArticlesError(this.error);

  @override
  List<Object> get props => [error!];
}

// States para la creación de artículos
class UserArticleCreating extends UserArticlesState {
  const UserArticleCreating();
}

class UserArticleCreatedSuccessfully extends UserArticlesState {
  const UserArticleCreatedSuccessfully();
}

class UserArticleCreationError extends UserArticlesState {
  final String message;

  const UserArticleCreationError(this.message);

  @override
  List<Object> get props => [message];
}