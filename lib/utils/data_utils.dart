import 'package:intl/intl.dart';

class DataUtils {
  static String numberFormat(double? value) {
    return NumberFormat("###,###,###,###").format(value);
  }

  static String simpleDayFormat(DateTime? time) {
    if (time == null) {
      return '';
    } else {
      return DateFormat('MM.dd').format(time);
    }
  }

  static double simpleFormatStringToDouble(String? value) {
    if (value == null) {
      return 0;
    } else {
      return double.parse(value);
    }
  }
}
