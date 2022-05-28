import 'package:flutter/material.dart';
import 'package:money_calculation_app/widgets/chart.dart';
import 'package:money_calculation_app/widgets/new_transaction.dart';
import 'package:money_calculation_app/widgets/transaction_list.dart';
import 'package:money_calculation_app/widgets/user_transaction.dart';

import 'models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Личные расходы',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // accentColor: Colors.amber,
        fontFamily: 'OpenSans',
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   data: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   data: DateTime.now(),
    // )
  ];

  List<Transaction> get recentlyTransaction {
    return userTransaction.where((element) {
      return element.data.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addNewTransaction(String TxTitle, double TxAmount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: TxTitle,
      amount: TxAmount,
      data: DateTime.now(),
    );
    setState(() {
      userTransaction.add(newTx);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewsTransaction(addNewTransaction),
            behavior: HitTestBehavior.opaque,
            onTap: () {},
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Личные расходы"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Chart(recentlyTransaction),
            ),
            TransactionList(userTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
