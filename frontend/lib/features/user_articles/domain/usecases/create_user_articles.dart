import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/entities/user_article_entity.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/repositories/user_article_repository.dart';

class CreateUserArticleUseCase implements UseCase<DataState<void>, UserArticleEntity> {
  final UserArticleRepository _userArticleRepository;

  CreateUserArticleUseCase(this._userArticleRepository);

  @override
  Future<DataState<void>> call({UserArticleEntity? params}) {
    if (params == null) {
      throw ArgumentError('UserArticleEntity params cannot be null');
    }
    return _userArticleRepository.createArticle(params);
  }
}
