import 'package:intl/intl.dart';
extension DateTimeEx on DateTime {
  String get uiDate {
    DateFormat format = DateFormat('dd/MM/yyyy');
    return format.format(this);
  }
  bool isSameDay(DateTime? other) {
    return
      year == other?.year &&
          month == other?.month &&
          day == other?.day;
  }
  String dayOfWeekStr ({bool todayReplace = false}){
    if(DateTime.now().isSameDay(this) && todayReplace) return 'Today';
    DateFormat format = DateFormat('EEEE');
    return format.format(this);
  }

  String get hourWithA {
    DateFormat format = DateFormat('hh:mm a');
    return format.format(this);
  }
}