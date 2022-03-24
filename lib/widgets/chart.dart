import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    //what this returns should be a list because i need multiple bars,
    // as a getter, this need a body where we return that list
    return List.generate(7, (index) {
      //we use list and then generate which is a utility constructor on the list class, List is a core Dart object, class
      //and it has a generate constructor which generates us a new list, in this constructor we define length and then function which will be called for every element,
      //it executes this function for every generated list element with index being 0,1,2,3,4,5,6,
      final weekDay = DateTime.now().subtract(Duration(days: index));
      //So for the first round when index is zero, we have duration of zero days so we subtract zero days which means we have still datetime now. in the next round, for the next list item, which is generated index is one, so we subtract one day, so that means now we generate a date which is yesterday and so on
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day':
            DateFormat('E', 'PL').format(weekDay).substring(0, 2).toUpperCase(),
        'amount': totalSum,
      };
      //in this function which we pass as a second argument to generate(), we return map, because i have a list of maps, so we can return something with curly braces to create a map
    }).reversed.toList();
    //reverse gives us a new iterable so we can then call toList on that and now we get a reversed list
  }

  // 0.0 is a starting value in our second argument we pass to fold we have to return new value which will be added to this starting value
  //item is the current element we are looking at
  double get totalWeekSpending {
    return groupedTransactionsValues.fold(0.0, (currentSum, item) {
      return currentSum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                totalWeekSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalWeekSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
