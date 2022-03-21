import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTransaction; //hold a pointer at a function
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(
      this.addTransaction); //add new transaction and bind whatever you get to addTransaction property

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return; //return stops the function execution, it means code after return won't be reached
    }
    addTransaction(
      enteredTitle,
      enteredAmount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Tytuł'),
              controller: titleController,
              onSubmitted: (_) =>
                  submitData(), //anonymous function where we get that value that onSubmited gives us
              // adding (_) is a kind of convention to signal i get an argument but i don't care about it here, i have to accept it but i don't plan on using it
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Kwota'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            FlatButton(
              onPressed: submitData,
              //double.parse() this is taking a string a convert it to a double

              child: Text('Dodaj wydatek'),
              textColor: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
