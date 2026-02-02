import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/entities/user_article_entity.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/repositories/user_article_repository.dart';

class GetUserArticlesUseCase implements UseCase<DataState<List<UserArticleEntity>>, void> {
  final UserArticleRepository _userArticleRepository;

  GetUserArticlesUseCase(this._userArticleRepository);

  @override
  Future<DataState<List<UserArticleEntity>>> call({void params}) {
    return _userArticleRepository.getUserArticles();
  }
}