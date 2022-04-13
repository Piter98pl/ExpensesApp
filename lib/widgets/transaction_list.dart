import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart'; // .. because we need to go up one level

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'Nie dodałeś żadnych wydatków',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    //empty box which we dont see on the screen but wchich still occupies its space,
                    //it still occupies 10 pixels
                    height: 20,
                  ),
                  //Flexible(
                  //Flexible helps size widgets that are relative to their parent,
                  //and if you want to adjust those widgets when their parents size changes
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              // builder method requires itemBuilder you must proivide this arguemnt,
              //itemBuilder takes a function that will give  us a context, we get that automatically,
              //Flutter manages that for us
              //context is this meta object with which we haven't really worked thus far,
              //which holds information about the position of the widget in the widget tree
              // it give us also a number of type int and that actually will be the index of the
              //item we're currently building.
              //To sum up. itemBuilder take a function so you need to provide a function here,
              //either a named function or as in here an anonymous function
              //the value of context(it can be any name) well be of type BuildContext,
              //this function is not called by me so it's not my job to provide these arguments,
              //it's called by Flutter because it calls this builder function here  for
              //every new item it wants to render on the screen
              // and it gives us a context which we don't need here but still we get it
              //and it gives us also and index of that item so is it the first item,
              //second item, third.... of the items it should render
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                            '${transactions[index].amount.toStringAsFixed(2)} zł'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ), //title is element in the middle
                  subtitle: Text(
                    DateFormat('yMMMEd', 'pl').format(transactions[index].date),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? FlatButton.icon(
                          color: Theme.of(context).errorColor,
                          textColor: Colors.white,
                          icon: Icon(Icons.delete),
                          label: Text('Usuń'),
                          onPressed: () {
                            deleteTransaction(transactions[index].id);
                          },
                        )
                      : IconButton(
                          //element at the end of that ListTile
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () {
                            deleteTransaction(transactions[index].id);
                          },
                        ),
                ),
              );

              // return Card(
              //   // in here we need to return a widget inside this builder method, that i built for this item we're currently looking at  so a widget that is build for the first item, for the second item and so on
              //   child: Row(
              //     children: [
              //       Container(
              //         padding: EdgeInsets.all(10),
              //         margin:
              //             EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.all(Radius.circular(10)),
              //           border: Border.all(
              //             color: Theme.of(context).colorScheme.primary,
              //             width: 2,
              //           ),
              //         ),
              //         child: Text(
              //           '${transactions[index].amount.toStringAsFixed(2)} zł',
              //           //interpolacja stringa, pewne miejsce w stringu zostaje zastąpione wartością za pomocą znaku $ oraz {}, nie musimy dodawac .toString
              //           //.toStringAsFixed(2) special kind of .toString which defines how many decimal places you want to show
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 24,
              //             color: Theme.of(context).colorScheme.primary,
              //           ),
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Container(
              //             margin: EdgeInsets.symmetric(vertical: 5),
              //             child: Text(transactions[index].title,
              //                 style: Theme.of(context).textTheme.headline6),
              //           ),
              //           Container(
              //             margin: EdgeInsets.symmetric(vertical: 5),
              //             child: Text(
              //               DateFormat('yMMMEd', 'pl')
              //                   .format(transactions[index].date),
              //               style: TextStyle(
              //                 fontSize: 14,
              //                 color: Colors.grey,
              //               ),
              //             ),
              //           )
              //         ],
              //       )
              //     ],
              //   ),
              // );
            },
            itemCount: transactions.length,
            // for ListView.builder() we cant provide children thing, instead what we need to provide is the itemCount argument and it defines how many items should be built,
            // in our case that would be the length of our transactions list, so we pass transactions.length
          );
  }
}
