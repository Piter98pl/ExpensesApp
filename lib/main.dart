import 'dart:io'; //convention is that u have dart import at the very top, then all packages like Fluter but other third-party packages as well in the next block below that and then below that, your own imports

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); // u need to set this in front of SystemChrome, otherwise orientation on some devices might not work
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]); //SystemChrome allows you to set some application wide or system wide settings for your app
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
          secondary: Color.fromARGB(255, 108, 164, 238),
        ),
        //errorColor: Colors.red,  its red by default
        //primary swatch is based on one single color but it automatically generates different
        //shades(odcienie) of that color automatically behind the scenes, all this shades
        //are generated on that one color you pass there
        //floatingButton by default take secondary color  as primary
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            //title theme for the rest of the app
            headline6: TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
          //title theme for the app bar
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 24,
            fontWeight: FontWeight.normal,
          ),
        ),
        // we assign new textTheme for our AppBar, so that all text elements in the AppBar
        //receive that theme and we based it on the default textTheme, so that we don't have to
        //overwrite everything like font sizes and so on,
        //but we use default texttheme and copy that with some overwritten values
        //now with that we are using the basic textTheme with our own settings mixed in and we
        //apply that to all texts in AppBar
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
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(
        //date is a datetime object and there Dart gives us and isAfter method,
        //only is transaction.date is after date that we pass in isAfter object,
        // this expresion return true and this transaction will be includedd in our _recentTransactions
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
    String transactionTitle,
    double transactionAmount,
    DateTime chosenDate,
  ) {
    final newTransaction = Transaction(
      title: transactionTitle,
      amount: transactionAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    // it's final because here I create it with the values that are passed into this method
    //so it is created based on value which i don't know at the point of time I'm writing the code ,
    // hence const can't be used here but I can use final because once that transaction
    // has been created with these dynamic values, it will not change again
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        //showModalBottomSheet needs at least two arguments the first is a value for context because internally,
        // this function will use this strange context object to show that modal sheet,
        //so we need to pass a value for context here, so we accept it as an argument
        // then we also need a builder. Builder now is a function that needs to return the widget that
        //should be inside of that modal bottom sheet, the builder function itself also give us a context ((_))
        // inside builder function you now return widget you want to show inside of that modal sheet
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
      //we have to return true if this is the element we want to remove
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pl', null);
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    //we getting acces to the orientation and then we check whether that value here is eaqual to  landscape,
    //and we store the result in a variable
    //isLanscape variable is recalculated whenever Flutter rebuilds the UI
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Kalkulator wydatków'),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              GestureDetector(
                child: Icon(CupertinoIcons.add),
                onTap: () => _startAddNewTransaction(context),
              )
            ]),
          )
        : AppBar(
            title: Text(
              'Kalkulator wydatków',
              style: TextStyle(fontFamily: 'OpenSans'),
            ),
            actions: [
              IconButton(
                onPressed: () => _startAddNewTransaction(context),
                //we need to forward there context   Widget build(BuildContext context) -
                //which is this context value here,
                icon: Icon(Icons.add),
              )
            ], //actions argument takes a list of widgets, theoretically you can add any widget in here,
            //like text or whatever you want, most typically you add icon buttons here
          );
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7, // we multiply the available height with 60%

      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                // You don't need to use curly braces after if in this case, it's a special "if inside of a list" syntax
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pokaż wykres',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch.adaptive(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                    //we need to forward there context   Widget build(BuildContext context) - which is this context value here
                  ),
          );
  }
}
