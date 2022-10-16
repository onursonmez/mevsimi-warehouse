import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';

// ignore: must_be_immutable
class QrInputArea extends StatefulWidget {
  final String txtHintText;
  final TextEditingController textController;
  final FocusNode textFocusNode;
  final Function(String value) btnFunction;
  final Color? buttonAllColor;
  final bool accept;
  late Function funcionListener;
  bool isSelected = false;
  QrInputArea(
      {Key? key,
      this.accept = false,
      required this.txtHintText,
      required this.btnFunction,
      this.buttonAllColor = AppColors.appGrey,
      required this.textController,
      required this.textFocusNode})
      : super(key: key);

  @override
  State<QrInputArea> createState() => _QrInputAreaState();
}

class _QrInputAreaState extends State<QrInputArea> {
  @override
  void initState() {
    super.initState();
    widget.funcionListener = () {
      if (widget.textFocusNode.hasFocus) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        widget.isSelected = true;
      } else {
        widget.isSelected = false;
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.86,
      height: context.width * 0.12,
      padding: context.paddingNormalHorizontal,
      decoration: BoxDecoration(
          color: widget.accept ? context.appGreen : null,
          border: Border.all(
              color: widget.accept ? context.appWhite : widget.buttonAllColor!,
              width: context.width * 0.005),
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                focusNode: widget.textFocusNode,
                onSubmitted: widget.btnFunction,
                controller: widget.textController,
                style: AppTextStyles.button20Regular.copyWith(
                    color: widget.accept ? context.appWhite : context.appBlack),
                decoration: InputDecoration(
                  hintText: widget.txtHintText,
                  hintStyle: AppTextStyles.button20Regular.copyWith(
                      color: widget.accept
                          ? context.appWhite
                          : AppColors.appGrey.withOpacity(0.5)),
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
              path: ImageConstants.instance.getQrImage,
              size: 0.074,
              iconColor: widget.accept ? context.appWhite : null,
            )
          ],
        ),
      ),
    );
  }
}

class CustomFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    return false;
  }
}
