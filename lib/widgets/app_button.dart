import 'package:ibec_test/constants/app_colors.dart';
import 'package:ibec_test/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    Key? key,
    required this.label,
    TextStyle? labelStyle,
    this.onPressed,
    bool? enabled,
  })  : shadowColor = null,
        color = AppColors.background,
        elevation = 0.0,
        borderColor = AppColors.neutral1,
        labelStyle = labelStyle ?? AppTextStyles.s14,
        enabled = enabled ?? true,
        super(key: key);

  final Color? borderColor;
  final Color color;
  final double? elevation;
  final String label;
  final TextStyle labelStyle;
  final VoidCallback? onPressed;
  final Color? shadowColor;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: enabled == true ? color : AppColors.neutralDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
          ),
        ),
        elevation: elevation,
        shadowColor: AppColors.buttonShadow1,
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
      ),
      child: Text(
        label,
        style: labelStyle,
        textAlign: TextAlign.center,
      ),
      onPressed: onPressed,
    );
  }
}
