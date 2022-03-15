import 'package:flutter/material.dart';

import './transaction.dart';

void main() => runApp(MyApp());

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator wydatków'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text('Tutaj będzie wykres :)'),
              elevation: 5,
            ),
          ),
          Column(
            children: transcations.map((transcation) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      child: Text(transcation.amount.toString()),
                    ),
                    Column(
                      children: [
                        Text(transcation.title),
                        Text(transcation.date.toString())
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
