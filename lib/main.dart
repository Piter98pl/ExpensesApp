import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';
import 'package:intl/date_symbol_data_local.dart';

import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String titleInput; //input values are always Strings by default

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

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        //showModalBottomSheet needs at least two arguments the first is a value for context because internally, this function will use this strange context object to show that modal sheet, so we need to pass a value for context here, so we accept it as an argument
        // then we also need a builder. Builder now is a function that needs to return the widget that should be inside of that modal bottom sheet, the builder function itself also give us a context ((_))
        // inside builder function you now return widget you want to show inside of that modal sheet
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pl', null);

    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator wydatków'),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(
                context), //we need to forward there context   Widget build(BuildContext context) - which is this context value here,
            icon: Icon(Icons.add),
          )
        ], //actions argument takes a list of widgets, theoretically you can cadd any widget in ehre, like text or whatever you want, most typically you add icon buttons here
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('Tutaj będzie wykres :)'),
                elevation: 5,
              ),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(
            context), //we need to forward there context   Widget build(BuildContext context) - which is this context value here
      ),
    );
  }
}
