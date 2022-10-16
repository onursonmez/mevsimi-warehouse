import 'package:flutter/material.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';

class QrButton extends StatelessWidget {
  final String txtHintText;
  final TextEditingController textController;
  final FocusNode? textFocusnode;
  final Function(String value)? btnFunction;
  final Color? buttonAllColor;
  final String iconPath;
  const QrButton(
      {Key? key,
      required this.txtHintText,
      required this.btnFunction,
      this.buttonAllColor = AppColors.appGrey,
      required this.iconPath,
      required this.textController,
      this.textFocusnode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.86,
      height: context.width * 0.12,
      padding: context.paddingNormalHorizontal,
      decoration: BoxDecoration(
          border:
              Border.all(color: buttonAllColor!, width: context.width * 0.005),
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                onSubmitted: btnFunction,
                controller: textController,
                decoration: InputDecoration(
                  hintText: txtHintText,
                  hintStyle: AppTextStyles.button20Regular
                      .copyWith(color: AppColors.appGrey.withOpacity(0.5)),
                  isCollapsed: true,
                  border: InputBorder.none,
                ),
              ),
            ),
            /*Text(
              buttonText,
              style: AppTextStyles.button16Regular
                  .copyWith(color: buttonAllColor),
              textAlign: TextAlign.center,
            ),*/
            SvgIcons(
              path: iconPath,
              size: 0.074,
            )
          ],
        ),
      ),
    );
  }
}
