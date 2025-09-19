import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:my_money/core/service/api_service.dart';
import 'package:my_money/core/service/token_service.dart';
import 'package:my_money/presentation/features/auth/service/auth_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton(() => FlutterSecureStorage());
  getIt.registerLazySingleton(() => ApiService());
  getIt.registerLazySingleton(() => TokenService(getIt<FlutterSecureStorage>()));
  getIt.registerLazySingleton(() => AuthService(getIt<TokenService>()));
  
}