import 'package:intl/intl.dart';
class DateHelper
{
  static String convertDateToParam(DateTime date)
  {
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
  static DateTime parseDate(String date)
  {
    return DateTime.parse(date);
  }
}