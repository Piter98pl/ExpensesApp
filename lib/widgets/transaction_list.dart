import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart'; // .. because we need to go up one level

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (context, index) {
          // builder method requires itemBuilder you must proivide this arguemnt,
          //itemBuilder takes a function that will give  us a context, we get that automatically Flutter manages that for us
          //context is this meta object with which we haven't really worked thus far, which holds information about the position of the widget in the widget tree
          // it give us also a number of type int and that actually will be the index of the item we're currently building.
          //To sum up. itemBuilder take a function so you need to provide a function here, either a named function or as in here an anonymous function
          //the value of context(it can be any name) well be BuildContext, this function is not called by me so it's not my job to provide these arguments, it's called by Flutter because it calls this builder function here  for every new item it wants to render on the screen
          // and it gives us a context which we don't need here but still we get it and it gives us also and index of that item so is it the first item, second item, third.... of the items it should render
          return Card(
            // in here we need to return a widget inside this builder method, that i built for this item we're currently looking at  so a widget that is build for the first item, for the second item and so on
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    '${transactions[index].amount.toStringAsFixed(2)} zł', //interpolacja stringa, pewne miejsce w stringu zostaje zastąpione wartością za pomocą znaku $ oraz {}, nie musimy dodawac .toString
//.toStringAsFixed(2) special kind of .toString which defines how many decimal places you want to show
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
                        transactions[index].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        DateFormat('yMMMEd', 'pl')
                            .format(transactions[index].date),
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
        },
        itemCount: transactions
            .length, // for ListView.builder() we cant provide children thing, instead what we need to provide is the itemCount argument and it defines how many items should be built,
        // in our case that would be the length of our transactions list, so we pass transactions.length
      ),
    );
  }
}
