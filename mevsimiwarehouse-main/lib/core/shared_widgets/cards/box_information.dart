import 'package:flutter/material.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';

import '../../../generated/locale_keys.g.dart';

class BoxInfIrmationCard extends StatelessWidget {
  final Product product;
  const BoxInfIrmationCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.height * 0.005),
      width: context.width * 0.92,
      height: context.width * 0.290,
      padding: context.paddingAllLowMedium,
      decoration: BoxDecoration(
        color: cardColor(product.statusId!).withOpacity(0.02),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: cardColor(product.statusId!), width: context.borderSize),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          product.productName! +
              "    " +
              product.id.toString() +
              "    ${product.productVariantName}",
          style: AppTextStyles.button16Bold.copyWith(
            color: cardColor(product.statusId!),
          ),
        ),
        SizedBox(
          height: context.lowMediumValue,
        ),
        Text(
          LocaleKeys.productPiece.locale + product.items!.length.toString(),
          style: AppTextStyles.button12Regular.copyWith(
            color: cardColor(product.statusId!),
          ),
        ),
        Text(
          LocaleKeys.shelfNumber.locale + (product.shelfNumber.toString()),
          style: AppTextStyles.button12Regular.copyWith(
            color: cardColor(product.statusId!),
          ),
        ),
        Text(
          LocaleKeys.status.locale + product.statusName!,
          style: AppTextStyles.button12Regular.copyWith(
            color: cardColor(product.statusId!),
          ),
        ),
        Text(
          LocaleKeys.firstOrder.locale +
              (product.isFirstOrder!
                  ? LocaleKeys.yes.locale
                  : LocaleKeys.no.locale),
          style: AppTextStyles.button12Regular.copyWith(
            color: cardColor(product.statusId!),
          ),
        ),
      ]),
    );
  }

  Color cardColor(int index) {
    switch (index) {
      case 2:
        return AppColors.darkOrange;
      case 3:
        return AppColors.appGreen;
      default:
        return AppColors.generalBlueColor;
    }
  }
}
