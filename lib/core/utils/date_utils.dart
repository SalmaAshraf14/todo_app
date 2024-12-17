import 'package:intl/intl.dart';

extension DateEx on DateTime {
  String get toFormattedDate {
    DateFormat formatter = DateFormat('dd / MM / YY');
    return formatter.format(this);
  }

  // String get dayName{
  //   List<String> days = ['MON', 'TUE', 'WEN', 'THS', 'FRI','SAT', 'SUN'];
  //   return days[weekday - 1];
  // }

  String get getDayName {
    DateFormat formatter = DateFormat('E');
    return formatter.format(this);
  }
}