import 'package:my_money/presentation/features/auth/service/auth_service.dart';
import 'package:my_money/service_locator.dart';

class SplashScreenViewModel {
  final AuthService authService = getIt.get<AuthService>();

  Future<void> initialize() async {
    await authService.initialize();
  }
}