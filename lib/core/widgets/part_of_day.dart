import 'package:intl/intl.dart';

class PartOfDay {
  static String getPart() {
    DateTime now = DateTime.now();

    String formatDate = DateFormat('kk').format(now);

    if (5 < int.parse(formatDate) && 16 > int.parse(formatDate)) {
      return 'Day';
    }
    if (16 <= int.parse(formatDate) && 21 >= int.parse(formatDate)) {
      return 'Mid Night';
    } else {
      return 'Night';
    }
  }
}
