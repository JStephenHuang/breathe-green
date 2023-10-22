import 'package:intl/intl.dart';

class DateTimeService {
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours);
  }

  String formatDateTime(String date) {
    return DateFormat.yMMMEd().format(DateTime.parse(date));
  }
}
