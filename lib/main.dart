import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pl'),
        const Locale('en'),
      ],
      title: 'Kalkulator wydatków',
      // this is the title you see when the app is in background mode, in the task manager and so on
      theme: ThemeData(
        // theme allows you to set up a global application-wide theme
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.amber,
        ),
        //primary swatch is based on one single color but it automatically generates different shades(odcienie) of that color automatically behind the scenes, all this shades are generated on that one color you pass there
        //floatingButton by default take secondary color  as primary
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            //title theme for the rest of the app
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.normal,
              fontSize: 22,
            ),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
          //title theme for the app bar
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 24,
              fontWeight: FontWeight.normal),
        ),
        // we assign new textTheme for our AppBar, so that all text elements in the AppBar receive that theme and we based it on the default textTheme, so that we don't have to overwrite everything like font sizes and so on,
        //but we use default texttheme and copy that with some overwritten values
        //now with that we are using the basic textTheme with our own settings mixed in and we apply that to all texts in AppBar
      ),
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
    // Transaction(
    //   id: 'tx1',
    //   title: 'Odżywka białkowa',
    //   amount: 42.50,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'tx2',
    //   title: 'Kreatyna',
    //   amount: 27.50,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(
        //date is a datetime object and there Dart gives us and isAfter method, only is transaction.date is after date that we pass in isAfter object, this expresion return true and this transaction will be includedd in our _recentTransactions
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String transactionTitle, double transactionAmount, DateTime chosenDate) {
    final newTransaction = Transaction(
      title: transactionTitle,
      amount: transactionAmount,
      date: chosenDate,
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
        title: Text(
          'Kalkulator wydatków',
          style: TextStyle(fontFamily: 'OpenSans'),
        ),
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
            Chart(_recentTransactions),
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
