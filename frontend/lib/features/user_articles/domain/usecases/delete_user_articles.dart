import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/repositories/user_article_repository.dart';

class DeleteUserArticleUseCase implements UseCase<DataState<void>, String> {
  final UserArticleRepository _userArticleRepository;

  DeleteUserArticleUseCase(this._userArticleRepository);

  @override
  Future<DataState<void>> call({String? params}) {
    if (params == null) {
      throw ArgumentError('Article ID params cannot be null');
    }
    return _userArticleRepository.deleteArticle(params);
  }
}
