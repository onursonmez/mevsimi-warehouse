import 'package:flutter/material.dart';

import '../../../../core/_core_exports.dart';

class ProductDetailViewModel extends ChangeNotifier {
  bool showFilledProducts = false;
  bool detailPage = true;
  bool endPage = false;
  late String cacheShelfNumber;

  ScanBarcodeEnum boxBarcodeEnum = ScanBarcodeEnum.NOTSUCCESS;
  ScanBarcodeEnum shelfBarcodeEnum = ScanBarcodeEnum.NOTSUCCESS;

  void clearClass() {
    showFilledProducts = false;
    endPage = false;
    detailPage = true;
    boxBarcodeEnum = ScanBarcodeEnum.NOTSUCCESS;
    shelfBarcodeEnum = ScanBarcodeEnum.NOTSUCCESS;
  }

  void changeShowFilledProducts() {
    showFilledProducts = !showFilledProducts;
    notifyListeners();
  }

  void changeDetailPage() {
    detailPage = !detailPage;
    notifyListeners();
  }

  void changeEndPage() {
    endPage = !endPage;
    notifyListeners();
  }

  bool scanBarcode(String? shelfBarcode, String boxBarcode, String value) {
    if (value == boxBarcode) {
      boxBarcodeEnum = ScanBarcodeEnum.SUCCESS;
    } else if (shelfBarcode != null && value == shelfBarcode) {
      cacheShelfNumber = shelfBarcode;
      shelfBarcodeEnum = ScanBarcodeEnum.SUCCESS;
    } else if (value is int) {
      boxBarcodeEnum = ScanBarcodeEnum.ERROR;
      ErrorSnackBar().showMessageSnackBar("Hatalı Kutu Barkod");
    } else {
      cacheShelfNumber = value;
      shelfBarcodeEnum = ScanBarcodeEnum.SUCCESS;
    }

    notifyListeners();
    if (boxBarcodeEnum == ScanBarcodeEnum.SUCCESS &&
        shelfBarcodeEnum == ScanBarcodeEnum.SUCCESS) {
      return true;
    } else {
      return false;
    }
  }

  void goHomePage() {
    clearClass();
    NavigationService.instance
        .navigateToPage(path: NavigationConstants.PRODUCTS_LIST);
  }
}
