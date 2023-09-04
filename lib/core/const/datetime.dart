import 'package:intl/intl.dart';

String formatDateTime(DateTime date) {
  return DateFormat.yMMMMd('pt_BR').format(date);
}