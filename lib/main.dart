import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import './transaction.dart';

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

class MyHomePage extends StatelessWidget {
  final List<Transcation> transcations = [
    Transcation(
      id: 1,
      title: 'Odżywka białkowa',
      amount: 42.50,
      date: DateTime.now(),
    ),
    Transcation(
      id: 2,
      title: 'Kreatyna',
      amount: 27.50,
      date: DateTime.now(),
    ),
  ];

  // String titleInput; //input values are always Strings by default
  // String amountInput;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pl', null);

    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator wydatków'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text('Tutaj będzie wykres :)'),
              elevation: 5,
            ),
          ),
          Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Tytuł'),
                      controller: titleController,
                      // onChanged: (val) {
                      //   titleInput = val;
                      // },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Kwota'),
                      controller: amountController,
                      // onChanged: (val) => amountInput = val,
                    ),
                    FlatButton(
                      onPressed: () {
                        print(titleController.text);
                        print(amountController.text);
                      },
                      child: Text('Dodaj wydatek'),
                      textColor: Colors.blue,
                    )
                  ],
                ),
              )),
          Column(
            children: transcations.map((transcation) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        '${transcation.amount} zł', //interpolacja stringa, pewne miejsce w stringu zostaje zastąpione wartością za pomocą znaku $ oraz {}
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.blue),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            transcation.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            DateFormat('yMMMEd', 'pl').format(transcation.date),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
