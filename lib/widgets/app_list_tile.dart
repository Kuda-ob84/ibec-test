import 'package:ibec_test/constants/app_colors.dart';
import 'package:ibec_test/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppListTile extends StatelessWidget {
  AppListTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.leading,
    this.trailing,
    this.boxShadow = const BoxShadow(
      color: Color.fromRGBO(16, 51, 115, 0.2),
      blurRadius: 10,
      offset: Offset(0, 0),
    ),
    this.contentPadding = const EdgeInsets.all(16.0),
    this.leadingPadding = const EdgeInsets.only(right: 16.0),
    this.color = AppColors.background,
    this.titleStyle = AppTextStyles.s16w500,
    this.chevronVisible = true,
    TextStyle? subtitleStyle,
  })  : subtitleStyle = subtitleStyle ??
            AppTextStyles.s14.copyWith(
              color: AppColors.neutralDark,
            ),
        super(key: key);

  final Color color;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry leadingPadding;
  final CircleAvatar? leading;
  final VoidCallback? onTap;
  final String? subtitle;
  final String title;
  final TextStyle? titleStyle;
  final Widget? trailing;
  final bool chevronVisible;
  final TextStyle subtitleStyle;
  final BoxShadow boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: contentPadding,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
        color: color,
        boxShadow: [boxShadow],
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            if (leading != null)
              Padding(
                padding: leadingPadding,
                child: leading!,
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    style: titleStyle,
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                        right: 16.0,
                      ),
                      child: Text(
                        subtitle!,
                        maxLines: 2,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: subtitleStyle,
                      ),
                    ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
            (chevronVisible && onTap != null)
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.arrow_right,
                      color: AppColors.dark,
                    ))
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
