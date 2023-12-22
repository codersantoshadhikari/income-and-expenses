import 'package:flutter/material.dart';



class IncomeTrackerApp extends StatelessWidget {
  const IncomeTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Income Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => IncomeTrackerPage(),
        '/income_entries': (context) => IncomeEntriesPage(),
      },
    );
  }
}

class IncomeEntry {
  String name;
  double amount;
  double sales;
  double cash;
  String remarks;

  IncomeEntry({
    required this.name,
    required this.amount,
    required this.sales,
    required this.cash,
    required this.remarks,
  });
}

class IncomeTrackerPage extends StatefulWidget {
  @override
  _IncomeTrackerPageState createState() => _IncomeTrackerPageState();
}

class _IncomeTrackerPageState extends State<IncomeTrackerPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController salesController = TextEditingController();
  TextEditingController cashController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  List<IncomeEntry> incomeEntries = [];

  void addIncomeEntry() {
    String name = nameController.text;
    double amount = double.tryParse(amountController.text) ?? 0.0;
    double sales = double.tryParse(salesController.text) ?? 0.0;
    double cash = double.tryParse(cashController.text) ?? 0.0;
    String remarks = remarksController.text;

    IncomeEntry entry = IncomeEntry(
      name: name,
      amount: amount,
      sales: sales,
      cash: cash,
      remarks: remarks,
    );

    setState(() {
      incomeEntries.add(entry);
      nameController.clear();
      amountController.clear();
      salesController.clear();
      cashController.clear();
      remarksController.clear();
    });
  }

  void navigateToIncomeEntriesPage() {
    Navigator.pushNamed(context, '/income_entries', arguments: incomeEntries);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Income Tracker'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Income Name:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: nameController,
              ),
              SizedBox(height: 16.0),
              Text(
                'Amount:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              Text(
                'Sales:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: salesController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              Text(
                'Cash:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: cashController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              Text(
                'Remarks:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: remarksController,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: addIncomeEntry,
                child: Text('Add Entry'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: navigateToIncomeEntriesPage,
                child: Text('View Income Entries'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IncomeEntriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<IncomeEntry> incomeEntries =
        ModalRoute.of(context)!.settings.arguments as List<IncomeEntry>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Income Entries'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Income Entries:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              DataTable(
                columns: [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Sales')),
                  DataColumn(label: Text('Cash')),
                  DataColumn(label: Text('Remarks')),
                ],
                rows: incomeEntries.map((entry) {
                  return DataRow(cells: [
                    DataCell(Text(entry.name)),
                    DataCell(Text(entry.amount.toString())),
                    DataCell(Text(entry.sales.toString())),
                    DataCell(Text(entry.cash.toString())),
                    DataCell(Text(entry.remarks)),
                  ]);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
