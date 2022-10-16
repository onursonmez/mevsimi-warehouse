import 'package:flutter/material.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';

class GlobalInputArea extends StatelessWidget {
  final TextEditingController? txtController;
  final FocusNode? txtFocusNode;
  final Function(String)? onSubmitFunction;
  final Function()? sufixButtonFunction;
  final bool? secretText;
  final bool? hideShowText;
  final String? txtHintText;
  const GlobalInputArea(
      {Key? key,
      this.txtController,
      this.txtFocusNode,
      this.onSubmitFunction,
      this.secretText = false,
      this.hideShowText = false,
      this.txtHintText,
      this.sufixButtonFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => txtFocusNode!.requestFocus(),
      child: Container(
        padding: context.paddingAllNormal,
        width: context.width * 0.77,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: !txtFocusNode!.hasFocus
                    ? AppColors.softLightBlue
                    : AppColors.darkBlue,
                width: context.width * 0.005)),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: TextField(
                controller: txtController,
                focusNode: txtFocusNode,
                obscureText: hideShowText!,
                onSubmitted: onSubmitFunction,
                decoration: InputDecoration(
                  hintText: txtHintText,
                  hintStyle: AppTextStyles.button20Regular
                      .copyWith(color: AppColors.darkBlue.withOpacity(0.5)),
                  isCollapsed: true,
                  border: InputBorder.none,
                ),
                style: AppTextStyles.button20Regular,
              ),
            ),
            secretText!
                ? GestureDetector(
                    onTap: sufixButtonFunction,
                    child: SvgIcons(
                      path: ImageConstants.instance.getEyesIcon,
                      size: 0.053,
                    ),
                  )
                : const SizedBox(),
          ],
        )),
      ),
    );
  }
}
