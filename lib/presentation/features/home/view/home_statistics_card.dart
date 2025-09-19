import 'package:flutter/material.dart';

class HomeStatisticsCard extends StatelessWidget {
  const HomeStatisticsCard({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 10,
      color: colorScheme.inverseSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your balance",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onInverseSurface,
                  ),
                ),
                Text(
                  "150,000,000 VND",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onInverseSurface,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_upward_outlined,
                            color: colorScheme.onInverseSurface,
                            size: 24,                          
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Income", 
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: colorScheme.onInverseSurface,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "10,000,000 VND",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onInverseSurface
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_downward_outlined,
                            color: colorScheme.onInverseSurface,
                            size: 24,                          
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Expense", 
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: colorScheme.onInverseSurface,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "10,000,000 VND",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onInverseSurface
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
