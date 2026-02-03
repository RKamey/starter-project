import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app_clean_architecture/features/user_articles/data/data_sources/user_article_firebase_data_source.dart';
import 'package:news_app_clean_architecture/features/user_articles/data/repositories/user_article_repository_impl.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/repositories/user_article_repository.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/usecases/create_user_articles.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/usecases/delete_user_articles.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/usecases/get_user_articles.dart';
import 'package:news_app_clean_architecture/features/user_articles/domain/usecases/upload_thumbnail.dart';
import 'package:news_app_clean_architecture/features/user_articles/presentation/bloc/user_article_bloc.dart';
import 'features/daily_news/data/data_sources/local/app_database.dart';
import 'features/daily_news/domain/usecases/get_saved_article.dart';
import 'features/daily_news/domain/usecases/remove_article.dart';
import 'features/daily_news/domain/usecases/save_article.dart';
import 'features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);
  
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Firebase
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  sl.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);

  // Dependencies - Daily News
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(
    ArticleRepositoryImpl(sl(),sl())
  );

  // Dependencies - User Articles
  sl.registerSingleton<UserArticleFirebaseDataSource>(
    UserArticleFirebaseDataSourceImpl(sl(), sl())
  );

  sl.registerSingleton<UserArticleRepository>(
    UserArticleRepositoryImpl(sl())
  );
  
  //UseCases - Daily News
  sl.registerSingleton<GetArticleUseCase>(
    GetArticleUseCase(sl())
  );

  sl.registerSingleton<GetSavedArticleUseCase>(
    GetSavedArticleUseCase(sl())
  );

  sl.registerSingleton<SaveArticleUseCase>(
    SaveArticleUseCase(sl())
  );
  
  sl.registerSingleton<RemoveArticleUseCase>(
    RemoveArticleUseCase(sl())
  );

  // UseCases - User Articles
  sl.registerSingleton<GetUserArticlesUseCase>(
    GetUserArticlesUseCase(sl())
  );

  sl.registerSingleton<CreateUserArticleUseCase>(
    CreateUserArticleUseCase(sl())
  );

  sl.registerSingleton<DeleteUserArticleUseCase>(
    DeleteUserArticleUseCase(sl())
  );

  sl.registerSingleton<UploadThumbnailUseCase>(
    UploadThumbnailUseCase(sl())
  );


  //Blocs - Daily News
  sl.registerFactory<RemoteArticlesBloc>(
    ()=> RemoteArticlesBloc(sl<GetUserArticlesUseCase>())
  );

  sl.registerFactory<LocalArticleBloc>(
    ()=> LocalArticleBloc(sl(),sl(),sl())
  );

  // Blocs - User Articles
  sl.registerFactory<UserArticlesBloc>(
    ()=> UserArticlesBloc(sl(), sl(), sl(), sl())
  );
}