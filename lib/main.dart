import 'widget/transaction_list.dart';
import 'package:flutter/material.dart';
import 'model/transaction.dart';
import 'widget/transaction_add.dart';
import 'widget/chart.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Transaction> _userTrx = [];
  
  List<Transaction> get _recentTransactions {
    return _userTrx.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
        const Duration(days: 7),
      ),);
    }).toList();
  }

  void _addNewTrx(String txtitle, double txamount, DateTime chosenDate) {
    final newTrx = Transaction(
        id: DateTime.now().toString(), title: txtitle, amount: txamount, date: chosenDate);
    setState(
      () {
        _userTrx.add(newTrx);
      },
    );
  }

  void _startAddNewTrx(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionAdd(_addNewTrx);
      },
    );
  }

  void _deleteTrx(String id) {
    setState(() {
      _userTrx.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("ExpensesApp"),
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Chart(_recentTransactions),
              TransactionList(_userTrx, _deleteTrx),
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (cx) => FloatingActionButton(
            onPressed: () => _startAddNewTrx(cx),
            child: Icon(Icons.add),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
