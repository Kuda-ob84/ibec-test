import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibec_test/constants/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool rootNavigator;
  final PreferredSizeWidget? bottom;
  final double height;
  final Widget? leading;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.bottom,
    this.height = 60,
    this.leading,
    this.rootNavigator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: AppTextStyles.s20w600,
      ),
      bottom: bottom,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
