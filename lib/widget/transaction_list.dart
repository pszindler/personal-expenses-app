import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;

  TransactionList(this.userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      child: SingleChildScrollView(
        child: userTransactions.isEmpty
            ? const Text("add new transaction")
            : Column(
                children: [
                  ...userTransactions.map((tx) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              '\$' + tx.amount.toString(),
                              style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.purple),
                            ),
                            margin: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.purple, width: 2),
                            ),
                            padding: EdgeInsets.all(10.0),
                          ),
                          Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tx.title,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              Text(
                                DateFormat.yMMMd('en_us').format(tx.date),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () => deleteTransaction(tx.id),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
      ),
    );
  }
}
