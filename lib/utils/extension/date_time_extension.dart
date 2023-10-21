import 'package:intl/intl.dart';
extension DateTimeEx on DateTime {
  String get uiDate {
    DateFormat format = DateFormat('dd/MM/yyyy');
    return format.format(this);
  }
}