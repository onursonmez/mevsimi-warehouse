import 'package:flutter/material.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';

class ProductInformationCard extends StatelessWidget {
  final Items items;
  final Function() onTapSelectItem;

  const ProductInformationCard({
    Key? key,
    required this.items,
    required this.onTapSelectItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapSelectItem,
      child: Container(
        width: context.width * 0.86,
        height: context.width * 0.12,
        padding: context.paddingNormalHorizontal,
        decoration: BoxDecoration(
            color: backgroundColor,
            border:
                Border.all(color: borderColor, width: context.width * 0.005),
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              items.name!,
              style: AppTextStyles.button16Regular.copyWith(color: textColor),
              textAlign: TextAlign.center,
            ),
            Text(
              items.quantity.toString(),
              style: AppTextStyles.button16Regular.copyWith(color: textColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color get borderColor {
    if (items.isSelected!) {
      return AppColors.generalBlueColor;
    } else if (!items.isSelected! && !items.cacheIsSelected!) {
      return AppColors.generalBlueColor;
    } else if (!items.isSelected! && items.cacheIsSelected!) {
      return AppColors.appGreen;
    }
    return AppColors.generalBlueColor;
  }

  Color get backgroundColor {
    if (items.isSelected! && items.cacheIsSelected!) {
      return AppColors.generalBlueColor;
    } else if (!items.isSelected! && !items.cacheIsSelected!) {
      return AppColors.appWhite;
    } else if (!items.isSelected! && items.cacheIsSelected!) {
      return AppColors.appGreen;
    } else if (items.isSelected! && !items.cacheIsSelected!) {
      return AppColors.appWhite;
    }
    return AppColors.generalBlueColor;
  }

  Color get textColor {
    if (items.isSelected! && items.cacheIsSelected!) {
      return AppColors.appWhite;
    } else if (!items.isSelected! && !items.cacheIsSelected!) {
      return AppColors.generalBlueColor;
    } else if (!items.isSelected! && items.cacheIsSelected!) {
      return AppColors.appWhite;
    } else if (items.isSelected! && !items.cacheIsSelected!) {
      return AppColors.generalBlueColor;
    }
    return AppColors.generalBlueColor;
  }
}
