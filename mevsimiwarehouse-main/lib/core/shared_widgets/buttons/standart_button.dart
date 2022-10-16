import 'package:flutter/material.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';

class StandartButton extends StatelessWidget {
  final Color? bacgraundColor;
  final String? buttonText;
  final Function() btnFunction;
  final Color? buttonTextColor;
  const StandartButton(
      {Key? key,
      this.bacgraundColor,
      this.buttonText,
      required this.btnFunction,
      this.buttonTextColor = AppColors.appWhite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: btnFunction,
        child: Ink(
          width: context.width * 0.77,
          padding: context.paddingNormalVertical,
          decoration: BoxDecoration(
              color: bacgraundColor,
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          child: Text(
            buttonText ?? "",
            style:
                AppTextStyles.button16Regular.copyWith(color: buttonTextColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
