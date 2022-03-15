import 'package:flutter/foundation.dart';

class Transcation {
  final int id;
  final String title;
  final double amount;
  final DateTime date;

  Transcation({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}
//@required is not a decorator that's build into Dart
//so in order for this to work we need to import something from Flutter
//because Flutter is actually the framework that introduces the required decorator
// we do this by importing package:foundation.dart it is the file that exposes @required