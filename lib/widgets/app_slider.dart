import 'package:beruang/core/constants/category_colors.dart';
import 'package:flutter/material.dart';
import 'package:multi_thumb_range_slider/multi_thumb_range_slider.dart';

class AppSlider extends StatelessWidget {
  final List<int> values;
  final int min;
  final int max;
  final ValueChanged<List<int>> onChanged;

  const AppSlider({
    super.key,
    required this.values,
    required this.onChanged,
    this.min = 0,
    this.max = 100,
  });

  @override
  Widget build(BuildContext context) {
    return CustomMultiThumbSlider.withInt(
      values: values,
      min: min,
      max: max,
      showTickmarks: false,
      tickmarkInterval: 10,
      showTickmarkLabels: false,
      tickmarkLabelInterval: 20,
      tickmarkSpacing: 16,
      labelSpacing: 16,
      showTooltip: false,
      valueFormatter: (v) => '$v%',
      height: 40,
      
      thumbRadius: 15,
      showSegments: false,
      segmentCardBackgroundColor: Theme.of(context).colorScheme.surface,
      segmentCardBorderColor: Theme.of(context).colorScheme.tertiary,
      segmentContentType: SegmentContentType.fromToRange,
      segmentTextColor: Theme.of(context).colorScheme.tertiary,
      segmentTextSize: 10,

      trackColor: Theme.of(context).colorScheme.surface,
      
      onChanged: (newValues) {
        onChanged([...newValues]..sort());
      },
      trackHeight: 20,
      rangeColors: [
        CategoryColors.needsChart,
        CategoryColors.wantsChart,
        CategoryColors.savingsChart,
        CategoryColors.donateChart
      ]
    );
  
  }
}
