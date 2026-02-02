import 'dart:io';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/repositories/user_article_repository.dart';

class UploadThumbnailParams {
  final File imageFile;
  final String articleId;

  UploadThumbnailParams({
    required this.imageFile,
    required this.articleId,
  });
}

class UploadThumbnailUseCase implements UseCase<DataState<String>, UploadThumbnailParams> {
  final UserArticleRepository _userArticleRepository;

  UploadThumbnailUseCase(this._userArticleRepository);

  @override
  Future<DataState<String>> call({UploadThumbnailParams? params}) {
    if (params == null) {
      throw ArgumentError('UploadThumbnailParams params cannot be null');
    }
    return _userArticleRepository.uploadThumbnail(params.imageFile, params.articleId);
  }
}
