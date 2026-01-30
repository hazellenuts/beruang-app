import 'package:beruang/core/constants/colors.dart';
import 'package:beruang/core/constants/spacing.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppHeader extends StatelessWidget {
  final bool isScrolled;
  final bool showHomeIcon;
  final VoidCallback? onHomeTap;
  final VoidCallback? onSettingsTap;

  const AppHeader({
    super.key,
    required this.isScrolled,
    this.showHomeIcon = false,
    this.onHomeTap,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: isScrolled
          ? Theme.of(context).colorScheme.surface
          : Colors.transparent,
      surfaceTintColor: Colors.transparent,

      leading: showHomeIcon
          ? Padding(padding: const EdgeInsets.only(left: AppSpacing.headerPadding),
            child: IconButton(
              icon: Icon(
                PhosphorIcons.houseSimple(PhosphorIconsStyle.fill),
                color: AppColors.accent,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          )
          : null,

      actions: [
        Padding(padding: const EdgeInsets.only(right: AppSpacing.headerPadding),
          child:IconButton(
          icon: Icon(
            PhosphorIcons.gearSix(PhosphorIconsStyle.fill),
            color: AppColors.accent,
            ),
            onPressed: onSettingsTap,
          ),
        ),
        
      ],

      bottom: isScrolled
          ? PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Divider(
                height: 1,
                thickness: 1,
                color: AppColors.accent,
              ),
            )
          : null,
    );
  }
}
