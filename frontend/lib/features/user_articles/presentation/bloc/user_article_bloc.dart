import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/entities/user_article_entity.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/usecases/create_user_articles.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/usecases/delete_user_articles.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/usecases/get_user_articles.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/usecases/upload_thumbnail.dart';
import 'package:news_app_clean_architecture/features/user_articles/presentation/bloc/user_article_event.dart';
import 'package:news_app_clean_architecture/features/user_articles/presentation/bloc/user_article_state.dart';

class UserArticlesBloc extends Bloc<UserArticlesEvent, UserArticlesState> {
  final GetUserArticlesUseCase _getUserArticlesUseCase;
  final CreateUserArticleUseCase _createUserArticleUseCase;
  final DeleteUserArticleUseCase _deleteUserArticleUseCase;
  final UploadThumbnailUseCase _uploadThumbnailUseCase;

  UserArticlesBloc(
    this._getUserArticlesUseCase,
    this._createUserArticleUseCase,
    this._deleteUserArticleUseCase,
    this._uploadThumbnailUseCase,
  ) : super(const UserArticlesLoading()) {
    on<GetUserArticles>(onGetUserArticles);
    on<CreateUserArticle>(onCreateUserArticle);
    on<DeleteUserArticle>(onDeleteUserArticle);
  }

  void onGetUserArticles(GetUserArticles event, Emitter<UserArticlesState> emit) async {
    final dataState = await _getUserArticlesUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(UserArticlesDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(UserArticlesError(dataState.error!));
    }
  }

  void onCreateUserArticle(CreateUserArticle event, Emitter<UserArticlesState> emit) async {
    emit(const UserArticleCreating());

    try {
      final String articleId = DateTime.now().millisecondsSinceEpoch.toString();
      String thumbnailURL = '';

      if (event.imageFile != null) {
        final uploadState = await _uploadThumbnailUseCase(
          params: UploadThumbnailParams(
            imageFile: event.imageFile!,
            articleId: articleId,
          ),
        );

        if (uploadState is DataSuccess) {
          thumbnailURL = uploadState.data!;
        } else {
          emit(const UserArticleCreationError('Error uploading thumbnail'));
          return;
        }
      }

      final article = UserArticleEntity(
        id: articleId,
        title: event.title,
        author: event.author,
        content: event.content,
        thumbnailURL: thumbnailURL,
        createdAt: DateTime.now(),
      );

      final dataState = await _createUserArticleUseCase(params: article);

      if (dataState is DataSuccess) {
        emit(const UserArticleCreatedSuccessfully());
        add(const GetUserArticles());
      }

      if (dataState is DataFailed) {
        emit(const UserArticleCreationError('Error creating article'));
      }
    } catch (e) {
      emit(UserArticleCreationError(e.toString()));
    }
  }

  void onDeleteUserArticle(DeleteUserArticle event, Emitter<UserArticlesState> emit) async {
    final dataState = await _deleteUserArticleUseCase(params: event.articleId);

    if (dataState is DataSuccess) {
      // Refrescar la lista
      add(const GetUserArticles());
    }

    if (dataState is DataFailed) {
      emit(UserArticlesError(dataState.error!));
    }
  }
}