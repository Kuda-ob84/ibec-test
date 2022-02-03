import 'package:flutter/material.dart';

import 'app_button.dart';

Future<T?> showAppDialog<T>(
    BuildContext context, {
      String? title,
      String? body,
      Widget Function(BuildContext context)? actions,
      bool barrierDismissible = true,
      bool showCancel = true,
    }) =>
    showDialog<T?>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Builder(
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      20.0,
                      20.0,
                      20.0,
                      0.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20.0),
                if (body != null)
                  Container(
                    padding: const EdgeInsets.fromLTRB(
                      20.0,
                      0.0,
                      20.0,
                      20.0,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            body,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (showCancel)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppElevatedButton(
                          label: "Okay",
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    ),
                  ),
                if (!showCancel && actions != null) actions(context),
              ],
            );
          },
        ),
      ),
    );
