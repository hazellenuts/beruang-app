import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final _formatter = NumberFormat.currency(
    locale: 'en_US',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  static String rupiah(num value) {
    return _formatter.format(value);
  }
}
