import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewsTransaction extends StatefulWidget {
  final Function addTX;

  NewsTransaction(this.addTX);

  @override
  State<NewsTransaction> createState() => _NewsTransactionState();
}

class _NewsTransactionState extends State<NewsTransaction> {
  final titleControlLer = TextEditingController();
  final amountControlLer = TextEditingController();

  void submitData() {
    final enteredTitle = titleControlLer.text;
    final enteredAmount = double.parse(amountControlLer.text);

    // if(enteredAmount.isInfinite || enteredAmount <= 0) {
    //   return;
    // }

    widget.addTX(
      titleControlLer.text,
      double.parse(amountControlLer.text),
    );
    // Закрываем окно после нажатие на значок(ок) - (НЕ РАБОТАЕТ)
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              // onChanged: (value) {
              //   titleInput = value;
              // },
              controller: titleControlLer,
              onSubmitted: (_) => submitData,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              // onChanged: (value) {
              //   amountInput = value;
              // },
              controller: amountControlLer,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData,
            ),
            ElevatedButton(
              onPressed: () {
                widget.addTX(
                  titleControlLer.text,
                  double.parse(amountControlLer.text),
                );
              },
              style: ElevatedButton.styleFrom(primary: Colors.greenAccent),
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  color: Colors.purple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
