import 'package:flutter/material.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';

class CounterButton extends StatelessWidget {
  final String buttonText;
  final int buttonCount;
  final Function()? btnFunction;
  final Color? buttonAllColor;
  final String? svgPath;
  const CounterButton({
    Key? key,
    required this.buttonText,
    this.btnFunction,
    this.buttonAllColor = AppColors.appGrey,
    this.buttonCount = 0,
    this.svgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: btnFunction,
        child: Ink(
          width: context.width * 0.86,
          height: context.width * 0.12,
          padding: EdgeInsets.only(
              right: context.lowValue, left: context.normalValue),
          decoration: BoxDecoration(
              border: Border.all(
                  color: buttonAllColor!, width: context.width * 0.005),
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                buttonText,
                style: AppTextStyles.button16Regular
                    .copyWith(color: buttonAllColor),
                textAlign: TextAlign.center,
              ),
              svgPath != null
                  ? Image.asset(svgPath!)
                  : Container(
                      width: context.width * 0.098,
                      height: context.height * 0.098,
                      decoration: BoxDecoration(
                          color: buttonAllColor, shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          buttonCount.toString(),
                          style: AppTextStyles.button11Bold
                              .copyWith(color: AppColors.appWhite),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
