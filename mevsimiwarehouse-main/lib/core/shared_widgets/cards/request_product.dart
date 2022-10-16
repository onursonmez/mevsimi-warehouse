import 'package:flutter/material.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';

import '../../../generated/locale_keys.g.dart';

class RequestBoxInfIrmationCard extends StatelessWidget {
  final Product product;
  const RequestBoxInfIrmationCard({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: context.width * 0.445,
      margin: EdgeInsets.only(top: context.height * 0.015),
      decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.darkOrange, width: context.borderSize),
          borderRadius: BorderRadius.circular(25),
          color: context.darkOrange),
      child: Column(
        children: [
          Container(
            width: context.width * 0.86,
            height: context.width * 0.345,
            padding: context.paddingAllNormal,
            decoration: BoxDecoration(
              color: context.appWhite,
              borderRadius: BorderRadius.circular(25),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                product.productName!,
                style: AppTextStyles.button20Regular
                    .copyWith(color: AppColors.generalBlueColor),
              ),
              Text(
                product.productName!,
                style: AppTextStyles.button12Regular
                    .copyWith(color: AppColors.darkGreen),
              ),
              SizedBox(
                height: context.lowMediumValue,
              ),
              Text(
                LocaleKeys.productPiece.locale +
                    product.items!.length.toString(),
                style: AppTextStyles.button12Regular
                    .copyWith(color: AppColors.darkGreen),
              ),
              Text(
                LocaleKeys.shelfNumber.locale + product.shelfNumber!.toString(),
                style: AppTextStyles.button12Regular
                    .copyWith(color: AppColors.darkGreen),
              ),
              Text(
                LocaleKeys.status.locale + product.statusName!,
                style: AppTextStyles.button12Regular
                    .copyWith(color: AppColors.darkGreen),
              ),
              Text(
                LocaleKeys.firstOrder.locale +
                    (product.isFirstOrder!
                        ? LocaleKeys.yes.locale
                        : LocaleKeys.no.locale),
                style: AppTextStyles.button12Regular
                    .copyWith(color: AppColors.darkGreen),
              ),
            ]),
          ),
          Expanded(
              child: Center(
                  child: Text(
            "Raf numarası formatı hatalı",
            style:
                AppTextStyles.button16Regular.copyWith(color: context.appWhite),
          )))
        ],
      ),
    );
  }
}
