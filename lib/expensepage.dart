import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'income_expenses.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key}) : super(key: key);

  @override
  ExpensePageState createState() => ExpensePageState();
}

class ExpensePageState extends State<ExpensePage> {
  final List<Income> incomeList = [];
  final List<Expenses> expensesList = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController cashController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  void addIncome() {
    final String name = nameController.text;
    final double amount = double.tryParse(amountController.text) ?? 0.0;
    final String sales = categoryController.text;
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
      nameController.clear();
      amountController.clear();
      categoryController.clear();
      cashController.clear();
      remarksController.clear();
      _showDetailsPage(incomeList, calculateTotal(incomeList));
    }
  }

  void addExpenses() {
    final String name = nameController.text;
    final double amount = double.tryParse(amountController.text) ?? 0.0;
    final String category = categoryController.text;
    final double cash = double.tryParse(cashController.text) ?? 0.0;
    final String remarks = remarksController.text;

    if (name.isNotEmpty && amount > 0) {
      final Expenses newExpense = Expenses(
        name: name,
        amount: amount,
        category: category,
        cash: cash,
        remarks: remarks,
      );
      expensesList.add(newExpense);
      nameController.clear();
      amountController.clear();
      categoryController.clear();
      cashController.clear();
      remarksController.clear();
      _showDetailsPage(expensesList, calculateTotal(expensesList));
    }
  }

  void _showDetailsPage(List<dynamic> itemList, double total) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          totalAmount: total,
          itemList: itemList,
        ),
      ),
    );
  }

  double calculateTotal(List<dynamic> itemList) {
    return itemList.fold(0, (prev, item) => prev + item.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Tracker'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildInputFields(),
          ],
        ),
      ),
    );
  }

  Widget buildInputFields() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
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
              onPressed: addExpenses,
              child: const Text('Sumbit'),
            ),
          ],
        ),
      ),
    );
  }
}

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

class Expenses {
  String name;
  double amount;
  String category;
  double cash;
  String remarks;

  Expenses({
    required this.name,
    required this.amount,
    required this.category,
    required this.cash,
    required this.remarks,
  });
}
