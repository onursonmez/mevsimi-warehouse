
import 'package:flutter/material.dart';

import '../_core_exports.dart';

void showCustomBottomSheet({
  required final Widget child,
  final double? height,
  final String? title,
}) {
  showModalBottomSheet(
    backgroundColor: AppColors.appGrey.withOpacity(.03),
    context: GlobalContextKey.instance.globalKey.currentContext!,
    isScrollControlled: true,
    builder: (final BuildContext context) => ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: height ?? ScreenSize().getHeightPercent(.815),
        minWidth: double.infinity,
      ),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
          color: AppColors.appWhite,
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenSize().getHeightPercent(.0097),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.appGrey,
                  borderRadius: BorderRadius.circular(2),
                ),
                width: ScreenSize().getWidthPercent(.064),
                height: ScreenSize().getHeightPercent(.0048),
              ),
              if (title != null)
                SizedBox(
                  height: ScreenSize().getWidthPercent(64 / 375),
                  width: double.infinity,
                  child: Center(
                    child: Text(title, style: AppTextStyles.button16Regular),
                  ),
                ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    ),
  );
}
