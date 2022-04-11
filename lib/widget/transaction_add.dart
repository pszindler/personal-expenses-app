import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionAdd extends StatefulWidget {
  final Function addTrx;

  TransactionAdd(this.addTrx);

  @override
  State<TransactionAdd> createState() => _TransactionAddState();
}

class _TransactionAddState extends State<TransactionAdd> {
  final inputTitle = TextEditingController();
  final inputAmount = TextEditingController();
  DateTime? datePicked;

  void onSubmit() {
    final enteredTitle = inputTitle.text;
    final enteredAmount = double.parse(inputAmount.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTrx(
      enteredTitle,
      enteredAmount,
      datePicked
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((date) {
          if (date == null) {
            return;
          }
          setState(() {
            datePicked = date;
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: inputTitle,
              onSubmitted: (_) => onSubmit,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: inputAmount,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => onSubmit,
            ),
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(datePicked == null ? "No date picked" : DateFormat.yMd().format(datePicked!)),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text('Choose Date'),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: onSubmit,
              child: const Text(
                "Add Transaction",
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10.0),
      ),
    );
  }
}
