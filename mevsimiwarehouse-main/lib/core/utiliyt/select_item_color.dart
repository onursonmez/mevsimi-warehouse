import 'package:flutter/material.dart';

import '../_core_exports.dart';

class ItemColor {
  Color allCardColor(ProductStatus productStatus) {
    switch (productStatus) {
      case ProductStatus.EMPTY:
        return AppColors.appWhite;
      case ProductStatus.WAITSERVICE:
        return AppColors.darkOrange.withOpacity(0.3);

    }
  }
}
