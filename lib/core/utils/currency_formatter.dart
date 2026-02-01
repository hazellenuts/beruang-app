import 'package:intl/intl.dart';

class CurrencyFormatter {
  static const double maxBalance = 9999999999999;

  static final _formatter = NumberFormat.currency(
    locale: 'en_US',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  /// Format rupiah dengan batas maksimum
  static String rupiah(num value) {
    final safeValue = value > maxBalance ? maxBalance : value;
    return _formatter.format(safeValue);
  }

  /// Validasi apakah nilai melebihi batas
  static bool isOverMax(num value) {
    return value > maxBalance;
  }
}
