import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_money/presentation/features/home/view/home_header.dart';
import 'package:my_money/presentation/features/home/view/home_statistics_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 500,
              width: double.infinity,
              child: Stack(
                children: [
                  HomeHeader(),
                  Positioned(
                    top: 100,
                    left: 20,
                    right: 20,
                    height: 200,
                    child: HomeStatisticsCard(),
                  ),
                  // SizedBox(height: 225)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
