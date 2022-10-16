// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';
import 'package:mevsimiwarehouse/view/deliverjob/repository/save_repository.dart';
import '../../../generated/locale_keys.g.dart';
import '../landing/repository/landing_repository.dart';

enum SearcheType { BOX_ID, SHELF_NUMBER }

class DeliverJobViewModel extends ChangeNotifier {
  DeliverJobViewModel() {
    fectProducts();
  }
  int filterStatus = 0;
  bool isLoad = false;
  dynamic jsonMockData;
  List<Product> lProduct = [];
  late Product product;
  List<Product> lFilter = [];
  List<Product> lLocaleStackProducts = [];

  List<Items> clonTotalItem = <Items>[];

  LandingRepository landingRepository = LandingRepository();

  late Product selectedProduct;

  clear() {
    isLoad = false;
  }

  List<Product> get filterProduct {
    if (filterStatus == 0) {
      return lProduct;
    }
    lFilter =
        lProduct.where((element) => element.statusId == filterStatus).toList();
    return lFilter;
  }

  final Map<String, dynamic> data = <String, dynamic>{};

  int get complatedProductCount =>
      lProduct.where((element) => element.statusId == 3).length;
  int get waitingShelfProductCount =>
      lProduct.where((element) => element.statusId == 2).length;
  int get waitingBoxProductCount =>
      lProduct.where((element) => element.statusId == 1).length;
  int get allProductsCount => lProduct.length;
  String get filterTypeString {
    switch (filterStatus) {
      case 0:
        return LocaleKeys.all.locale;
      case 1:
        return LocaleKeys.waitingBoxStarted.locale;
      case 2:
        return LocaleKeys.waitingProductOnShelf.locale;
      case 3:
        return LocaleKeys.complete.locale;
      default:
        return "";
    }
  }

  Future<void> fectProducts() async {
    Items _item;
    clonTotalItem = <Items>[];
    bool _check = false;
    changeIsLoad();
    lProduct = [];

    product = Product();
    lProduct = (await landingRepository.fetchDeliverJob())!;

    if (lProduct.isNotEmpty) {
      for (var product in lProduct) {
        for (var item in product.items!) {
          _check = true;
          for (var totalItem in clonTotalItem) {
            if (item.name == totalItem.name) {
              _check = false;
              break;
            }
          }
          if (_check) {
            _item = Items(
              cacheIsSelected: false,
              id: item.id,
              isSelected: false,
              name: item.name,
              quantity: item.quantity,
            );

            clonTotalItem.add(_item);
          }
        }
      }
    }
    clonTotalItem.sort();

    changeIsLoad();
  }

  Future<void> saveProductLocale() async {
    data['products'] = lProduct.map((v) => v.toJson()).toList();
    await LocaleManager.instance.setStringValue(
        PreferencesKeys.PRODUCTS_LIST, json.encode(data['products']));
  }

  Future<void> getProductLocale() async {
    jsonMockData = json.decode(LocaleManager.instance.getStringValue(
      PreferencesKeys.PRODUCTS_LIST,
    ));
  }

  Future<void> changeSelected(int selectedItem) async {
    selectedProduct.items![selectedItem].cacheIsSelected =
        !selectedProduct.items![selectedItem].cacheIsSelected!;
    notifyListeners();
  }

  void selectedItem(int index) {
    clonTotalItem[index].cacheIsSelected =
        !clonTotalItem[index].cacheIsSelected!;
    notifyListeners();
  }

  void selectProduct(int selectedItem) async {
    for (var item in filterProduct[selectedItem].items!) {
      item.cacheIsSelected = item.isSelected;
    }
    selectedProduct = filterProduct[selectedItem];

    NavigationService.instance
        .navigateToPage(path: NavigationConstants.PRODUCT_DETAIL);
    notifyListeners();
  }

  void searcheProductBox(String boxBarcode) async {
    bool _itemInList = false;
    for (var item in lProduct) {
      if (item.id.toString() == boxBarcode ||
          item.shelfNumber.toString() == boxBarcode) {
        selectedProduct = item;
        _itemInList = true;
        NavigationService.instance
            .navigateToPage(path: NavigationConstants.PRODUCT_DETAIL);
        break;
      }
    }
    if (!_itemInList) {
      ErrorSnackBar().showMessageSnackBar("ÜRÜN BULUNAMADI");
    }
  }

  void changeIsLoad() {
    isLoad = !isLoad;
    notifyListeners();
  }

  Future<void> resetProduct() async {
    selectedProduct.shelfNumber = "";
    selectedProduct.statusId = 1;
    selectedProduct.statusName = "Kutulama Bekliyor";
    for (final item in selectedProduct.items!) {
      item.isSelected = false;
      item.cacheIsSelected = false;
    }
    if (ApplicationConstants.connection!) {
      changeIsLoad();
      await SaveRepository().updateProduct(
          productModel: selectedProduct, paramModel: selectedProduct);
      FlutterBeep.beep(true);
      changeIsLoad();
    }
  }

  Future<void> saveProduct() async {
    bool _complate = true;

    if (ApplicationConstants.connection!) {
      changeIsLoad();
      await SaveRepository().updateProduct(
          productModel: selectedProduct, paramModel: selectedProduct);
      FlutterBeep.beep(true);
      changeIsLoad();
    } else {
      lLocaleStackProducts.add(selectedProduct);

      lProduct[lProduct.indexOf(selectedProduct)] = selectedProduct;
    }
    for (var item in selectedProduct.items!) {
      item.isSelected = item.cacheIsSelected;

      if (!item.cacheIsSelected!) _complate = false;
    }
    if (_complate) {
      selectedProduct.statusId = 3;
      selectedProduct.statusName = "Sipariş Tamamlandı.";
    } else {
      selectedProduct.statusId = 2;
      selectedProduct.statusName = "Rafta Ürün Bekliyor.";
    }
  }

  Future<void> saveItem(String boxBarcode) async {
    if (boxBarcode == "READ_FAIL") {
      ErrorSnackBar().showMessageSnackBar("Hatalı Barkod");
      return;
    }
    bool _isInBox = false;
    for (var item in lProduct) {
      if (item.id.toString() == boxBarcode) {
        selectedProduct = item;
        _isInBox = true;
        break;
      }
    }
    if (!_isInBox) {
      ErrorSnackBar().showMessageSnackBar("Barkod Bulunamadı");
      return;
    }
    bool _isInItem = false;
    for (var item in clonTotalItem) {
      for (var productItems in selectedProduct.items!) {
        if (item.name == productItems.name &&
            item.cacheIsSelected! &&
            !productItems.isSelected!) {
          _isInItem = true;
          productItems.cacheIsSelected = !productItems.cacheIsSelected!;
        }
      }
    }
    if (!_isInItem) {
      ErrorSnackBar()
          .showMessageSnackBar("Bulunamadı Veya Daha Önce Eklenmiştir!");
      return;
    }
    bool _complate = true;

    if (ApplicationConstants.connection!) {
      changeIsLoad();
      await SaveRepository().updateProduct(
          productModel: selectedProduct, paramModel: selectedProduct);
      FlutterBeep.beep(true);
      changeIsLoad();
    } else {
      lLocaleStackProducts.add(selectedProduct);

      lProduct[lProduct.indexOf(selectedProduct)] = selectedProduct;
    }
    for (var item in selectedProduct.items!) {
      item.isSelected = item.cacheIsSelected;

      if (!item.cacheIsSelected!) _complate = false;
    }
    if (_complate) {
      selectedProduct.statusId = 3;
      selectedProduct.statusName = "Sipariş Tamamlandı.";
    } else {
      selectedProduct.statusId = 2;
      selectedProduct.statusName = "Rafta Ürün Bekliyor.";
    }
  }

  void clearCloneItem() {
    for (var item in clonTotalItem) {
      item.cacheIsSelected = false;
      item.isSelected = false;
    }
    notifyListeners();
  }
}
