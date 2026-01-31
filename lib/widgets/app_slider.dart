import 'package:beruang/core/constants/category_colors.dart';
import 'package:beruang/core/constants/colors.dart';
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
      segmentCardBackgroundColor: AppColors.surface,
      segmentCardBorderColor: AppColors.outline,
      segmentContentType: SegmentContentType.fromToRange,
      segmentTextColor: AppColors.outline,
      segmentTextSize: 10,

      trackColor: AppColors.surface,
      
      onChanged: (newValues) {
        onChanged([...newValues]..sort());
      },
      trackHeight: 30,
      rangeColors: [
        CategoryColors.needsChart,
        CategoryColors.wantsChart,
        CategoryColors.savingsChart,
        CategoryColors.donateChart
      ]
    );
  
  }
}
