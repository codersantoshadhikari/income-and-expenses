import 'package:flutter/material.dart';
import 'expensepage.dart';
import 'income.dart';

void main() {
  runApp(const CashFlowApp());
}

class CashFlowApp extends StatelessWidget {
  const CashFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cash Flow Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CashFlowHomePage(),
    );
  }
}

class CashFlowHomePage extends StatelessWidget {
  const CashFlowHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 128, 127, 148),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 128, 127, 148),
        title: const Text('Cash Flow Tracker'),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 128, 127, 148),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 128, 127, 148),
              ),
              child: Text('Cash Flow Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: const Text('Income'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const IncomeTrackerApp()));
              },
            ),
            ListTile(
              title: const Text('Expenses'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExpensePage()));
              },
            ),
            // ListTile(
            //   title: const Text('Transaction'),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const TransactionPage()));
            //   },
            // ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Welcome to Cash Flow Tracker!'),
      ),
    );
  }
}
