import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Future<T?> showAppBottomSheet<T>(
    BuildContext context, {
      Widget? child,
      Widget? subChild,
      bool expanded = false,
      bool isDismissible = true,
      bool isScrollControlled = true,
      bool useRootNavigator = false,
      double initialChildSize = 0.9,
      double minChildSize = 0.25,
      double maxChildSize = 1.0,
      String? title,
      String? leading,
      String? trailing,
      VoidCallback? leadingOnPressed,
      VoidCallback? trailingOnPressed,
    }) {
  return showModalBottomSheet<T>(
    useRootNavigator: useRootNavigator,
    context: context,
    isScrollControlled: isScrollControlled,
    isDismissible: isDismissible,
    backgroundColor: const Color(0xFFFFFFFF),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    builder: (_) {
      return Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: 7.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xFFDDE1E5),
              ),
            ),
            Column(
              children: [
                if (title != null || trailing != null || leading != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      leading != null
                          ? IconButton(
                        onPressed: leadingOnPressed ??
                                () => Navigator.pop(context),
                        padding: const EdgeInsets.all(0),
                        icon: SvgPicture.asset(
                          leading,
                        ),
                      )
                          : const SizedBox(width: 50),
                      Text(
                        title ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF151C22),
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      trailing != null
                          ? IconButton(
                        onPressed: trailingOnPressed ??
                                () => Navigator.pop(context),
                        icon: SvgPicture.asset(
                          trailing,
                        ),
                      )
                          : const SizedBox(width: 50),
                    ],
                  ),
                subChild ?? const SizedBox.shrink(),
              ],
            ),
            child ?? const SizedBox.shrink(),
          ],
        ),
      );
    },
  );
}
