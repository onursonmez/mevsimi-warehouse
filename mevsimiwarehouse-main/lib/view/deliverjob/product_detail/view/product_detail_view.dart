import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';
import 'package:provider/provider.dart';
import '../../../../core/shared_widgets/cards/barcode_card.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../_view_exports.dart';
import 'package:pointmobile_scanner/pointmobile_scanner.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({Key? key}) : super(key: key);

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  void initState() {
    super.initState();
    PointmobileScanner.channel.setMethodCallHandler(_onBarcodeScannerHandler);
    PointmobileScanner.initScanner();
  }

  late String barcode;
  Future<void> _onBarcodeScannerHandler(MethodCall call) async {
    try {
      barcode = call.arguments[1].toString();
      if (barcode == "READ_FAIL") {
        ErrorSnackBar()
            .showMessageSnackBar("BARKOD OKUMA SIRASINDA HATA OLUŞTU");
      } else {
        if (Provider.of<ProductDetailViewModel>(context, listen: false)
            .scanBarcode(
                Provider.of<DeliverJobViewModel>(context, listen: false)
                    .selectedProduct
                    .shelfNumber,
                Provider.of<DeliverJobViewModel>(context, listen: false)
                    .selectedProduct
                    .id
                    .toString(),
                barcode)) {
          Provider.of<DeliverJobViewModel>(context, listen: false)
                  .selectedProduct
                  .shelfNumber =
              Provider.of<ProductDetailViewModel>(context, listen: false)
                  .cacheShelfNumber;
          Provider.of<DeliverJobViewModel>(context, listen: false)
              .saveProduct();
        }
      }
    } catch (e) {
      ErrorSnackBar().showMessageSnackBar("BARKOD OKUMA SIRASINDA HATA OLUŞTU");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: !Provider.of<DeliverJobViewModel>(context, listen: true).isLoad
              ? SafeArea(
                  child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GeneralAppBar(
                      backArrowButton: () {
                        PointmobileScanner.channel.setMethodCallHandler(null);
                        Provider.of<ProductDetailViewModel>(context,
                                listen: false)
                            .goHomePage();
                      },
                    ),
                    Expanded(child: productDetailBody(context))
                  ],
                ))
              : Center(
                  child: CircularProgressIndicator(color: context.appGreen),
                ),
        ),
        onWillPop: () async {
          PointmobileScanner.channel.setMethodCallHandler(null);
          Provider.of<ProductDetailViewModel>(context, listen: false)
              .goHomePage();
          return false;
        });
  }

  Widget productDetailBody(BuildContext context) {
    return Consumer2<DeliverJobViewModel, ProductDetailViewModel>(
      builder: (context, deliverJobViewModel, productDetailViewModel, child) =>
          Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  left: ScreenSize().getWidthPercent(0.07),
                  top: context.lowMediumValue,
                  bottom: context.lowMediumValue),
              child: Text(
                LocaleKeys.detail.locale,
                style: AppTextStyles.button24Regular,
              ),
            ),
          ),
          BoxDetailInformationCard(
              product: deliverJobViewModel.selectedProduct,
              reset: () => deliverJobViewModel.resetProduct()),
          SizedBox(
            height: context.lowValue,
          ),
          productDetailViewModel.endPage
              ? endPage(context)
              : productDetailViewModel.detailPage
                  ? itemBody(context)
                  : scanBody(context)
        ],
      ),
    );
  }

  Widget itemBody(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Consumer<ProductDetailViewModel>(
            builder: (context, productDetailViewModel, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.justShowWaitingProduct.locale,
                    style: AppTextStyles.button16Regular
                        .copyWith(color: context.darkGreen),
                  ),
                  Switch(
                      value: productDetailViewModel.showFilledProducts,
                      onChanged: (value) {
                        productDetailViewModel.changeShowFilledProducts();
                      })
                ],
              );
            },
          ),
          Consumer2<DeliverJobViewModel, ProductDetailViewModel>(
            builder:
                (context, deliverJobViewModel, productDetailViewModel, child) {
              return Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return productDetailViewModel.showFilledProducts &&
                              deliverJobViewModel
                                  .selectedProduct.items![index].isSelected!
                          ? const SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ProductInformationCard(
                                    items: deliverJobViewModel
                                        .selectedProduct.items![index],
                                    onTapSelectItem: () async {
                                      deliverJobViewModel.changeSelected(index);
                                    }),
                              ],
                            );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: context.lowValue,
                        ),
                    itemCount:
                        deliverJobViewModel.selectedProduct.items!.length),
              );
            },
          ),
          StandartButton(
            btnFunction: () {
              Provider.of<ProductDetailViewModel>(context, listen: false)
                  .changeDetailPage();
            },
            bacgraundColor: context.generalBlueColor,
            buttonText: LocaleKeys.continuet.locale,
          ),
          SizedBox(
            height: context.highValue,
          ),
        ],
      ),
    );
  }

  Widget scanBody(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  LocaleKeys.boxAndSheldBarcodeScan.locale,
                  style: AppTextStyles.button24Regular
                      .copyWith(color: context.darkGreen),
                ),
                SizedBox(
                  height: context.mediumValue,
                ),
                Consumer2<ProductDetailViewModel, DeliverJobViewModel>(
                  builder: (context, productDetailViewModel,
                      deliverJobViewModel, child) {
                    return Column(children: [
                      BarcodeCard(
                        barcodeValue:
                            deliverJobViewModel.selectedProduct.id.toString(),
                        iconPath: ImageConstants.instance.getBocIcon,
                        scanBarcodeEnum: productDetailViewModel.boxBarcodeEnum,
                        hintBarcodeValue:
                            deliverJobViewModel.selectedProduct.id.toString(),
                      ),
                      SizedBox(
                        height: context.mediumValue,
                      ),
                      BarcodeCard(
                          barcodeValue:
                              deliverJobViewModel.selectedProduct.shelfNumber ??
                                  "",
                          iconPath: ImageConstants.instance.getBarcodeIcon,
                          scanBarcodeEnum:
                              productDetailViewModel.shelfBarcodeEnum),

                      /*     QrInputArea(
                          txtHintText: LocaleKeys.scanBox.locale,
                          accept: productDetailViewModel.acceptBocBarcode,
                          btnFunction: (value) {
                            productDetailViewModel.onSubmitBox(
                                value,
                                deliverJobViewModel.selectedProduct.id
                                    .toString());
                          },
                          textController:
                              productDetailViewModel.textBoxBarcodeController,
                          textFocusNode:
                              productDetailViewModel.focusBoxBarcode),
                      SizedBox(
                        height: context.mediumValue,
                      ),
                      QrInputArea(
                        txtHintText: LocaleKeys.scanShelf.locale,
                        textController:
                            productDetailViewModel.textShelfController,
                        btnFunction: (String value) {
                          deliverJobViewModel.selectedProduct.shelfNumber =
                              value;
                          if (productDetailViewModel.onSubmitShelf(
                              value,
                              deliverJobViewModel
                                  .selectedProduct.shelfNumber!)) {
                            deliverJobViewModel.saveProduct();
                          }
                        },
                        textFocusNode: productDetailViewModel.focusShelf,
                      ),*/
                    ]);
                  },
                ),
              ],
            ),
          ),
          StandartButton(
            btnFunction: () {
              Provider.of<ProductDetailViewModel>(context, listen: false)
                  .changeDetailPage();
            },
            bacgraundColor: context.generalBlueColor,
            buttonText: LocaleKeys.goBack.locale,
          ),
          SizedBox(
            height: context.highValue,
          ),
        ],
      ),
    );
  }

  Widget endPage(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SvgIcons(
              path: ImageConstants.instance.getProductSavedImage,
              size: .86,
            ),
          ),
          Consumer<ProductDetailViewModel>(
            builder: (context, productDetailViewModel, child) => StandartButton(
              btnFunction: () {
                productDetailViewModel.goHomePage();
              },
              bacgraundColor: context.generalBlueColor,
              buttonText: LocaleKeys.homePage.locale,
            ),
          ),
          SizedBox(
            height: context.highValue,
          ),
        ],
      ),
    );
  }
}
