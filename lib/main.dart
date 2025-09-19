import 'package:flutter/material.dart';
import 'package:my_money/core/routing/app_router.dart';
import 'package:my_money/core/theme/app_theme.dart';
import 'package:my_money/presentation/features/auth/service/auth_service.dart';
import 'package:my_money/presentation/features/auth/viewmodel/login_view_model.dart';
import 'package:my_money/service_locator.dart';
import 'package:provider/provider.dart';

void main() {
  setupServiceLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter().appRouter();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => getIt.get<AuthService>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        routerConfig: appRouter,
      ),
    );
  }
}
