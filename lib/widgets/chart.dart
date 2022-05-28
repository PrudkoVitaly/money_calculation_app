import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_calculation_app/models/transaction.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentlyTransaction;

  Chart(this.recentlyTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i < recentlyTransaction.length; i++) {
        if (recentlyTransaction[i].data.day == weekDay &&
            recentlyTransaction[i].data.month == weekDay &&
            recentlyTransaction[i].data.year == weekDay) {
          totalSum += recentlyTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: groupedTransactionValues.map((data) {
          // return Text('${data['day']}: ${data['amount']}');
          return ChartBar(
              data['day'].toString(),
              data['amount'],
              totalSpending == 0.0
                  ? 0.0
                  : (data['amount'] as double) / totalSpending);
        }).toList(),
      ),
    );
  }
}
