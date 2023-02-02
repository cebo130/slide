import 'package:flutter/material.dart';

class DatePicked with ChangeNotifier {
  String dateShit = '';
  String get dateShitF => dateShit;
  String dateIt(String a){
    dateShit = a;
    return a;
  }
}