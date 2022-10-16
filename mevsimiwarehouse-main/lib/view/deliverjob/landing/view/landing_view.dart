import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';
import 'package:mevsimiwarehouse/core/shared_widgets/bottom_showsheet.dart';
import 'package:mevsimiwarehouse/generated/locale_keys.g.dart';
import 'package:pointmobile_scanner/pointmobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../../_view_exports.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
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
      Provider.of<LandingViewModel>(context, listen: false)
          .textOrderNumber
          .clear();
      Provider.of<DeliverJobViewModel>(context, listen: false)
          .searcheProductBox(barcode);
      PointmobileScanner.channel.setMethodCallHandler(_onBarcodeScannerHandler);
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
                    children: [
                      GeneralAppBar(backArrowButton: () async {
                        await backButton(context);
                        /* Provider.of<LoginViewModel>(context, listen: false)
                            .clearViewModel();
                        await LocaleManager.instance.setStringValue(
                            PreferencesKeys.LOGIN_INFORMATION, "");
                        NavigationService.instance
                            .navigateToPage(path: NavigationConstants.LOGIN);*/
                      }),
                      landingBody(context)
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(color: context.appGreen),
                ),
        ),
        onWillPop: () async {
          await backButton(context);

          return false;
        });
  }

  Future<void> backButton(BuildContext context) async {
    return showCustomBottomSheet(
        title: "Çıkış Yapmak İstediğinizden Emin Misiniz",
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
                  Navigator.pop(context);

                  Provider.of<LoginViewModel>(context, listen: false)
                      .clearViewModel();
                  await LocaleManager.instance
                      .setStringValue(PreferencesKeys.LOGIN_INFORMATION, "");
                  NavigationService.instance
                      .navigateToPage(path: NavigationConstants.LOGIN);
                }),
            SizedBox(
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
  }

  Widget landingBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(
                left: ScreenSize().getWidthPercent(0.07),
                right: ScreenSize().getWidthPercent(0.07),
                top: context.lowMediumValue,
                bottom: context.width * 0.2),
            child: Column(
              children: [
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Merhaba',
                              style: AppTextStyles.button24Regular
                                  .copyWith(color: context.darkGreen)),
                          TextSpan(
                              text: "  " +
                                  Provider.of<LoginViewModel>(context)
                                      .login
                                      .name!,
                              style: AppTextStyles.button24Bold
                                  .copyWith(color: context.darkGreen)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: context.width * 0.05,
                ),
                dateTimePicker(),
                Provider.of<DeliverJobViewModel>(context, listen: true)
                        .lProduct
                        .isNotEmpty
                    ? buttonBody()
                    : Column(
                        children: [
                          SizedBox(
                            height: context.width * 0.3,
                          ),
                          Center(
                            child: Image.asset(
                                ImageConstants.instance.toEmptyBox,
                                height: context.height * 0.2),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget dateTimePicker() {
    return Consumer2<LandingViewModel, DeliverJobViewModel>(
      builder: (context, landingViewModel, deliverJobViewModel, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  landingViewModel.datePicker(false);
                  deliverJobViewModel.fectProducts();
                },
                icon: const Icon(Icons.arrow_back_ios_outlined)),
            Text(
              landingViewModel.datePickerValue.toString().substring(0, 10),
              style: AppTextStyles.button16Bold,
            ),
            IconButton(
                onPressed: () {
                  landingViewModel.datePicker(true);
                  deliverJobViewModel.fectProducts();
                },
                icon: const Icon(Icons.arrow_forward_ios_outlined)),
          ],
        );
      },
    );
  }

  Column buttonBody() {
    return Column(
      children: [
        SizedBox(
          height: context.height * .02,
        ),
        Consumer2<DeliverJobViewModel, LandingViewModel>(
          builder: (context, deliverJobViewModel, landingViewModel, child) {
            return QrButton(
                btnFunction: (value) {
                  landingViewModel.textOrderNumber.clear();
                  deliverJobViewModel.searcheProductBox(value);
                },
                txtHintText: LocaleKeys.orderNumberSearche.locale,
                iconPath: ImageConstants.instance.orderNumberIcon,
                textFocusnode: landingViewModel.focusOrderNumber,
                textController: landingViewModel.textOrderNumber);
          },
        ),
        SizedBox(
          height: context.normalValue,
        ),
        Consumer<DeliverJobViewModel>(
          builder: (context, deliverJobViewModel, child) => CounterButton(
            svgPath: ImageConstants.instance.getTomato,
            buttonText: "Ürün Bazlı Kutulama",
            btnFunction: () async {
              NavigationService.instance
                  .navigateToPage(path: NavigationConstants.ITEMS_VIEW);
            },
            buttonAllColor: AppColors.appRed,
          ),
        ),
        SizedBox(
          height: context.normalValue,
        ),
        Consumer<DeliverJobViewModel>(
          builder: (context, deliverJobViewModel, child) => CounterButton(
            buttonText: LocaleKeys.all.locale,
            btnFunction: () {
              deliverJobViewModel.filterStatus = 0;
              NavigationService.instance
                  .navigateToPage(path: NavigationConstants.PRODUCTS_LIST);
            },
            buttonAllColor: context.appRed,
            buttonCount: deliverJobViewModel.allProductsCount,
          ),
        ),
        SizedBox(
          height: context.normalValue,
        ),
        Consumer<DeliverJobViewModel>(
          builder: (context, deliverJobViewModel, child) => CounterButton(
            buttonText: LocaleKeys.waitingBoxStarted.locale,
            btnFunction: () async {
              deliverJobViewModel.filterStatus = 1;
              NavigationService.instance
                  .navigateToPage(path: NavigationConstants.PRODUCTS_LIST);
            },
            buttonAllColor: context.generalBlueColor,
            buttonCount: deliverJobViewModel.waitingBoxProductCount,
          ),
        ),
        SizedBox(
          height: context.normalValue,
        ),
        Consumer<DeliverJobViewModel>(
          builder: (context, deliverJobViewModel, child) => CounterButton(
            buttonText: LocaleKeys.waitingProductOnShelf.locale,
            btnFunction: () async {
              deliverJobViewModel.filterStatus = 2;
              NavigationService.instance
                  .navigateToPage(path: NavigationConstants.PRODUCTS_LIST);
            },
            buttonAllColor: context.darkOrange,
            buttonCount: deliverJobViewModel.waitingShelfProductCount,
          ),
        ),
        SizedBox(
          height: context.normalValue,
        ),
        Consumer<DeliverJobViewModel>(
          builder: (context, deliverJobViewModel, child) => CounterButton(
            buttonText: LocaleKeys.complete.locale,
            btnFunction: () async {
              deliverJobViewModel.filterStatus = 3;
              NavigationService.instance
                  .navigateToPage(path: NavigationConstants.PRODUCTS_LIST);
            },
            buttonAllColor: context.appGreen,
            buttonCount: deliverJobViewModel.complatedProductCount,
          ),
        )
      ],
    );
  }
}
