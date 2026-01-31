class SliderUtils {
  static List<double> calculatePercents(List<int> thumbs, int max) {
    final List<double> percents = [];

    int prev = 0;
    for (final t in thumbs) {
      percents.add((t - prev).toDouble());
      prev = t;
    }

    percents.add((max - prev).toDouble());
    return percents;
  }
}
