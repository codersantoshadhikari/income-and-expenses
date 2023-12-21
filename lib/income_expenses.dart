import 'package:flutter/material.dart';

import 'income.dart';

class DetailsPage extends StatelessWidget {
  final double totalAmount;
  final List<dynamic> itemList;

  const DetailsPage({Key? key, required this.totalAmount, required this.itemList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            buildItemList(),
          ],
        ),
      ),
    );
  }

  Widget buildItemList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        final item = itemList[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text(
              'Category: ${item is Income ? item.sales : item.category}, Cash: \$${item.cash.toStringAsFixed(2)}, Remarks: ${item.remarks}'),
          trailing: Text('\$${item.amount.toStringAsFixed(2)}'),
        );
      },
    );
  }
}

class NextPage extends StatelessWidget {
  final double totalIncome;
  final List<Income> incomeList;

  const NextPage({Key? key, required this.totalIncome, required this.incomeList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Income Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Total Income on Next Page: \$${totalIncome.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Income Details on Next Page:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            buildIncomeList(),
          ],
        ),
      ),
    );
  }

  Widget buildIncomeList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: incomeList.length,
      itemBuilder: (context, index) {
        final income = incomeList[index];
        return ListTile(
          title: Text(income.name),
          subtitle: Text(
              'Sales: ${income.sales}, Cash: \$${income.cash.toStringAsFixed(2)}, Remarks: ${income.remarks}'),
          trailing: Text('\$${income.amount.toStringAsFixed(2)}'),
        );
      },
    );
  }
}
