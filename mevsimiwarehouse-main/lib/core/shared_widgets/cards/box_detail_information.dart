import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';
import 'package:mevsimiwarehouse/generated/locale_keys.g.dart';

import '../bottom_showsheet.dart';

class BoxDetailInformationCard extends StatelessWidget {
  final Product product;
  final VoidCallback? reset;

  const BoxDetailInformationCard({Key? key, required this.product, this.reset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: context.height * 0.009),
          width: context.width * 0.86,
          height: context.width * 0.240,
          padding: context.paddingAllLowMedium,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: AppColors.generalBlueColor, width: context.borderSize),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  product.productName! + "  -  " + product.id.toString(),
                  style: AppTextStyles.button20Regular
                      .copyWith(color: AppColors.generalBlueColor),
                ),
                SizedBox(
                  height: context.lowValue,
                ),
                Text(
                  LocaleKeys.productPiece.locale +
                      product.items!.length.toString(),
                  style: AppTextStyles.button12Regular
                      .copyWith(color: AppColors.darkGreen),
                ),
                Text(
                  LocaleKeys.shelfNumber.locale +
                      (product.shelfNumber.toString()),
                  style: AppTextStyles.button12Regular
                      .copyWith(color: AppColors.darkGreen),
                ),
                Text(
                  LocaleKeys.status.locale + product.statusName!,
                  style: AppTextStyles.button12Regular
                      .copyWith(color: AppColors.darkGreen),
                ),
              ]),
              reset == null
                  ? const SizedBox.shrink()
                  : IconButton(
                      onPressed: () {
                        showCustomBottomSheet(
                            title:
                                "Kutuyu Sıfırlamak İstediğinizden Emin Misiniz",
                            height: ScreenSize().getHeightPercent(.3),
                            child: Column(
                              children: [
                                CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    child: Container(
                                      color: AppColors.appGrey.withOpacity(.03),
                                      width: double.infinity,
                                      height: ScreenSize().getWidthPercent(.15),
                                      child: Center(
                                        child: Text(
                                          "Evet",
                                          style: AppTextStyles.button16Regular,
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      reset?.call();
                                      Navigator.pop(context);
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    child: Container(
                                      color: AppColors.appGrey.withOpacity(.03),
                                      width: double.infinity,
                                      height: ScreenSize().getWidthPercent(.15),
                                      child: Center(
                                        child: Text(
                                          "Hayır",
                                          style: AppTextStyles.button16Regular,
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    })
                              ],
                            ));
                      },
                      icon: const Icon(Icons.refresh))
            ],
          ),
        ),
        product.isFirstOrder!
            ? Positioned(
                top: 0,
                right: context.normalValue,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppColors.generalBlueColor,
                  ),
                  child: Center(
                    child: Text(LocaleKeys.firstOrderCard.locale,
                        style: AppTextStyles.button11Regular
                            .copyWith(color: AppColors.appWhite)),
                  ),
                  width: context.width * 0.17,
                  height: context.height * 0.025,
                ))
            : const SizedBox(),
      ],
    );
  }
}
