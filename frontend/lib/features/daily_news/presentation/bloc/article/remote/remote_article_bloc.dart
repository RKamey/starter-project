import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/usecases/get_user_articles.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
  
  final GetUserArticlesUseCase _getUserArticlesUseCase;
  
  RemoteArticlesBloc(this._getUserArticlesUseCase) : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(GetArticles event, Emitter<RemoteArticlesState> emit) async {
    emit(const RemoteArticlesLoading());
    
    final dataState = await _getUserArticlesUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      final articles = dataState.data!.map((userArticle) {
        return ArticleEntity(
          id: userArticle.id != null ? int.tryParse(userArticle.id!) : null,
          author: userArticle.author,
          title: userArticle.title,
          description: null,
          url: null,
          urlToImage: userArticle.thumbnailURL,
          publishedAt: userArticle.createdAt?.toIso8601String(),
          content: userArticle.content,
        );
      }).toList();
      
      emit(RemoteArticlesDone(articles));
    } else if (dataState is DataSuccess && dataState.data!.isEmpty) {
      // Lista vacía
      emit(const RemoteArticlesDone([]));
    }
    
    if (dataState is DataFailed) {
      emit(RemoteArticlesError(dataState.error!));
    }
  }
}
