import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);
  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  //hold a pointer at a function
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  //add new transaction and bind whatever you get to addTransaction property
  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return; //return stops the function execution, it means code after return won't be reached
    }
    widget.addTransaction(
      // thanks to widget. i can access poperty addTransaction which has this function reference i get even though i'm tehnically in different class
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
    //closing the topmost screen that is displayed and that is that modal sheet if it's opened
    //.of(context) here is required to get access to the right navigator or to give the navigator some meta data
    //and context here is a special property which is available class wide in state class here even though you never defined a property named context
    // it's made available because we extend state
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      locale: const Locale('pl', 'PL'),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
//showDatePicker also needs to know the context of the widget in which you're calling it, context here on the right refers to that class property context
    ).then((pickedDate) {
      if (pickedDate == null) {
        // if true, then user pressed cancel and then we just return in this anonymous function and not continue with any other code
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    // then() simply allows us to provide a function which is executed once the Future resolves(rozstrzygać, zadecydować) to a value, so once the user chose a date
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Tytuł'),
              controller: _titleController,
              onSubmitted: (_) =>
                  _submitData(), //anonymous function where we get that value that onSubmited gives us
              // adding (_) is a kind of convention to signal i get an argument but i don't care about it here, i have to accept it but i don't plan on using it
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Kwota'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            Container(
              height: 90,
              child: Row(
                children: [
                  Expanded(
                    // now this will take as much space as it can get and only leave the button here as much space as it needs
                    child: Text(
                      _selectedDate == null
                          ? 'Brak wybranej daty!'
                          : 'Wybrana Data: ${DateFormat.yMMMEd('pl').format(_selectedDate)}', // always format() take the date, not the DateFormat.yM() constructor
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Wybierz datę',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                    textColor: Theme.of(context).colorScheme.primary,
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: _submitData,
              //double.parse() this is taking a string a convert it to a double
              child: Text('Dodaj wydatek'),
              color: Theme.of(context).colorScheme.primary,
              textColor: Theme.of(context).textTheme.button.color,
            )
          ],
        ),
      ),
    );
  }
}
