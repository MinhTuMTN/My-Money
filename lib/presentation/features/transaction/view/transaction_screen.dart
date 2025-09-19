import 'package:flutter/material.dart';
import 'package:my_money/presentation/features/transaction/view/header.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
        children: [
          _buildSectionTitle(colorScheme),
          _buildListTransactionType(colorScheme),
        ],
      ),
    );
  }

  Widget _buildListTransactionType(ColorScheme colorScheme) {
    var transactionTypes = ['All', 'Income', 'Expense'];

    return Container(
      height: 50,
      color: colorScheme.surfaceContainer,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: transactionTypes.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext _, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.amber,
            child: Text(transactionTypes[index], style: TextStyle(color: colorScheme.onSurface, fontSize: 16, fontWeight: FontWeight.w500)),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(ColorScheme colorScheme) {
    return Container(
      color: colorScheme.surfaceContainer,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Transaction History",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onInverseSurface,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildIcon(Icons.search),
                  SizedBox(width: 10),
                  _buildIcon(Icons.filter_alt),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFFDFDFD),
      ),
      width: 35,
      height: 35,
      child: Icon(icon, color: Colors.grey),
    );
  }
}
