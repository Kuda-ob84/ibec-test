import 'package:ibec_test/constants/app_colors.dart';
import 'package:ibec_test/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  AppTextField({
    Key? key,
    this.textAlign,
    this.hintText,
    this.onChanged,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    EdgeInsetsGeometry? contentPadding,
    bool enabled = true,
    this.style,
    this.hintStyle,
    TextEditingController? controller,
    FocusNode? focusNode,
  })  : contentPadding = contentPadding ?? const EdgeInsets.all(17.0),
        controller = controller ?? TextEditingController(),
        focusNode = focusNode ?? FocusNode(),
        super(key: key);

  final TextAlign? textAlign;
  final Function(String value)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextStyle? hintStyle;
  final String? hintText;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final TextStyle? style;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();

  Future<void> dispose() async {
    controller.dispose();
  }
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          textAlign: widget.textAlign ?? TextAlign.left,
          controller: widget.controller,
          maxLength: widget.maxLength,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          focusNode: widget.focusNode,
          style: widget.style ?? AppTextStyles.s16w500,
          decoration: InputDecoration(
            fillColor: AppColors.background,
            filled: true,
            isDense: true,
            contentPadding: widget.contentPadding,
            hintStyle: widget.hintStyle ??
                AppTextStyles.s16w500.copyWith(
                  color: AppColors.grey,
                ),
            hintText: widget.hintText,
            counterText: '',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.5),
              ),
              gapPadding: 0.0,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1.0,
              ),
              gapPadding: 0.0,
            ),
          ),
          onChanged: (value) {
            widget.onChanged?.call(value);
          },
        ),
      ],
    );
  }
}
