import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_money/presentation/features/splash/viewmodel/splash_screen_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashScreenViewModel viewModel = SplashScreenViewModel();

  @override
  void initState() {
    viewModel.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceContainer,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Nền trong suốt
          statusBarIconBrightness: Brightness.light, // Icon sáng (trắng)
          statusBarBrightness: Brightness.dark, // Đối với iOS (nền tối)
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: colorScheme.surfaceContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "MY MONEY",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colorScheme.onInverseSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ]
        ),
      ),
    );
  }
}