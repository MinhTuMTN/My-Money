import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_money/core/routing/route_name.dart';

class MainScreen extends StatefulWidget {
  final StatefulNavigationShell child;
  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final routes = [
    RouteName.HOME_SCREEN,
    RouteName.TRANSACTION_SCREEN,
    RouteName.STATISTIC_SCREEN,
    RouteName.PROFILE_SCREEN,
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const iconData = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.list, 'label': 'Transaction'},
      {'icon': Icons.bar_chart, 'label': 'Statistic'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];
    return Scaffold(
      body: widget.child,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => context.push(RouteName.ADD_EXPENSE_SCREEN),
        backgroundColor: colorScheme.surfaceContainer,
        child: Icon(Icons.add, color: Colors.white, size: 30,)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconData.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? colorScheme.surfaceContainer : colorScheme.secondary;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData[index]['icon'] as IconData, color: color, size: 30),
            ],
          );
        },
        activeIndex: widget.child.currentIndex,
        splashColor: colorScheme.primary,
        splashSpeedInMilliseconds: 30,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        gapLocation: GapLocation.center,
        borderColor: Colors.grey,        
        elevation: 4,
        onTap: (index) => setState(() => widget.child.goBranch(index)),
      ),
    );
  }
}
