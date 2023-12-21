import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'income_expenses.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({Key? key}) : super(key: key);

  @override
  IncomePageState createState() => IncomePageState();
}

class IncomePageState extends State<IncomePage> {
  final List<Income> incomeList = [];
  final TextEditingController incomeNameController = TextEditingController();
  final TextEditingController incomeAmountController = TextEditingController();
  final TextEditingController salesController = TextEditingController();
  final TextEditingController cashController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  void addIncome() {
    final String name = incomeNameController.text;
    final double amount = double.tryParse(incomeAmountController.text) ?? 0.0;
    final String sales = salesController.text;
    final double cash = double.tryParse(cashController.text) ?? 0.0;
    final String remarks = remarksController.text;

    if (name.isNotEmpty && amount > 0) {
      final Income newIncome = Income(
        name: name,
        amount: amount,
        sales: sales,
        cash: cash,
        remarks: remarks,
      );
      incomeList.add(newIncome);
      incomeNameController.clear();
      incomeAmountController.clear();
      salesController.clear();
      cashController.clear();
      remarksController.clear();
      _showIncomeDetailsPage();
    }
  }

  void _showIncomeDetailsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextPage(
          totalIncome: calculateTotalIncome(),
          incomeList: incomeList,
        ),
      ),
    );
  }

  double calculateTotalIncome() {
    return incomeList.fold(0, (prev, income) => prev + income.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Income Tracker'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildIncomeInput(),
          ],
        ),
      ),
    );
  }

  Widget buildIncomeInput() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: incomeNameController,
              decoration: const InputDecoration(labelText: 'Income Name'),
            ),
            TextField(
              controller: incomeAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            TextField(
              controller: salesController,
              decoration: const InputDecoration(labelText: 'Sales'),
            ),
            TextField(
              controller: cashController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Cash'),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            TextField(
              controller: remarksController,
              decoration: const InputDecoration(labelText: 'Remarks'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addIncome,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

// class NextPage extends StatelessWidget {
//   final double totalIncome;
//   final List<Income> incomeList;

//   NextPage({Key? key, required this.totalIncome, required this.incomeList})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Income Details'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Total Income on Next Page: \$${totalIncome.toStringAsFixed(2)}',
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Income Details on Next Page:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             buildIncomeList(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildIncomeList() {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: incomeList.length,
//       itemBuilder: (context, index) {
//         final income = incomeList[index];
//         return ListTile(
//           title: Text(income.name),
//           subtitle: Text(
//               'Sales: ${income.sales}, Cash: \$${income.cash.toStringAsFixed(2)}, Remarks: ${income.remarks}'),
//           trailing: Text('\$${income.amount.toStringAsFixed(2)}'),
//         );
//       },
//     );
//   }
// }
class Income {
  String name;
  double amount;
  String sales;
  double cash;
  String remarks;

  Income({
    required this.name,
    required this.amount,
    required this.sales,
    required this.cash,
    required this.remarks,
  });
}
