import 'package:flutter/material.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';

class BarcodeCard extends StatelessWidget {
  final ScanBarcodeEnum scanBarcodeEnum;
  final String iconPath;
  final String barcodeValue;
  final String? hintBarcodeValue;
  const BarcodeCard(
      {Key? key,
      required this.scanBarcodeEnum,
      required this.iconPath,
      required this.barcodeValue,
      this.hintBarcodeValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.86,
      height: context.width * 0.290,
      decoration: BoxDecoration(
        color: cardColor().withOpacity(0.04),
        border: Border.all(color: cardColor(), width: context.borderSize),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
          child: Row(
        children: [
          Padding(
            padding: context.paddingAllHigh,
            child: SvgIcons(
              path: iconPath,
              iconColor: cardColor(),
              size: 0.15,
            ),
          ),
          Expanded(
              child: Text(
            barcodeValue,
            textAlign: TextAlign.center,
            style: AppTextStyles.button24Regular.copyWith(color: cardColor()),
          ))
        ],
      )),
    );
  }

  Color cardColor() {
    switch (scanBarcodeEnum) {
      case ScanBarcodeEnum.SUCCESS:
        return AppColors.appGreen;
      case ScanBarcodeEnum.NOTSUCCESS:
        return AppColors.appGrey;
      case ScanBarcodeEnum.ERROR:
        return AppColors.appRed;
      default:
        return AppColors.darkOrange;
    }
  }
}
