import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double SpendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.SpendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height:
              20, // now the text at the top will always have a height od 20 no matter how much height it needs
          child: FittedBox(
            child: Text('${spendingAmount.toStringAsFixed(0)} zł'),
          ),
        ),
        //toStringAsFixes(0) removes decimal places and i only show rounded integer value
        SizedBox(height: 5),
        Container(
          height: 70,
          width: 14,
          child: Stack(children: [
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
        SizedBox(height: 5),
        Container(
          height: 14,
          child: FittedBox(
            child: Text(label),
          ),
        ),
      ],
    );
  }
}
