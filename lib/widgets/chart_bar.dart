import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double SpendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.SpendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        //LayoutBuilder giveds us information about the constraints that are applied to this widget we are  in so to the chart bar,
        // no matter if we explicitly set these constraints by assigning a size on some parent widget or
        //if these are the default constraints of the built-in widget we're placing our widget in
        // in that builder we should now return the widget tree for our custom widget,
        //and now we have the constraints object available
        // and we can use that to dynamically calculate the height and width, if we need it,
        //of elements inside of that widget based on the constraints
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.15,
              // height:
              //     20, // now the text at the top will always have a height od 20 no matter how much height it needs
              child: FittedBox(
                child: Text('${spendingAmount.toStringAsFixed(0)} zł'),
              ),
            ),
            //toStringAsFixes(0) removes decimal places and i only show rounded integer value
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 15,
              child: Stack(alignment: Alignment.bottomCenter, children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: SpendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )
              ]),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
