import 'package:flutter/material.dart';

import './transaction_list.dart';
import './new_transaction.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 'tx1',
      title: 'Odżywka białkowa',
      amount: 42.50,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'tx2',
      title: 'Kreatyna',
      amount: 27.50,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String transactionTitle, double transactionAmount) {
    final newTransaction = Transaction(
      title: transactionTitle,
      amount: transactionAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );
    // it's final because here I create it with the values that are passed into this method so it is created based on value which i don't know at the point of time I'm writing the code , hence const can't be used here but I can use final because once that transaction has been created with these dynamic values, it will not change again
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
