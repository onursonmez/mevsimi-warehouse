import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';
import 'package:mevsimiwarehouse/view/deliverjob/viewmodel/_viewmodel_exports.dart';
import 'package:provider/provider.dart';

class GeneralAppBar extends StatefulWidget {
  final Function() backArrowButton;
  const GeneralAppBar({Key? key, required this.backArrowButton})
      : super(key: key);

  @override
  State<GeneralAppBar> createState() => _GeneralAppBarState();
}

class _GeneralAppBarState extends State<GeneralAppBar> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  String connectionInformation(int connectionStatus) {
    switch (connectionStatus) {
      case 0:
        ApplicationConstants.connection = true;
        return "online";
      case 1:
        ApplicationConstants.connection = true;
        return "online";
      case 3:
        ApplicationConstants.connection = true;
        return "ONLINE-M";
      case 4:
        ApplicationConstants.connection = false;
        return "OFFLINE";
      default:
        ApplicationConstants.connection = false;
        return "offline";
    }
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.width * 0.16 + context.lowMediumValue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: context.lowMediumValue,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: context.paddingLowHorizontal,
                //width: ScreenSize().getWidthPercent(0.18),
                height: ScreenSize().getWidthPercent(0.030),
                decoration: BoxDecoration(
                    color: _connectionStatus.index == 1
                        ? context.appGreen
                        : context.darkOrange,
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: Text(
                    connectionInformation(_connectionStatus.index),
                    style: AppTextStyles.button11Regular
                        .copyWith(color: AppColors.appWhite),
                  ),
                ),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: widget.backArrowButton,
              child: SvgIcons(
                path: ImageConstants.instance.getBackButtonIcon,
                size: 0.10,
              ),
            ),
            SvgIcons(
              path: ImageConstants.instance.appBarIamge,
              size: 0.6,
            ),
            GestureDetector(
              onTap: () {
                NavigationService.instance.navigateToPage(
                    path: NavigationConstants.REQUEST_PRODUCT_VIEW);
              },
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: context.lowValue),
                    child: SvgIcons(
                      path: ImageConstants.instance.getApiCloudIcon,
                      size: 0.08,
                    ),
                  ),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: context.mediumValue,
                        height: context.mediumValue,
                        decoration: BoxDecoration(
                            color: context.generalBlueColor,
                            shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            Provider.of<DeliverJobViewModel>(context,
                                    listen: true)
                                .lLocaleStackProducts
                                .length
                                .toString(),
                            style: AppTextStyles.button11Regular
                                .copyWith(color: context.appWhite),
                          ),
                        ),
                      )),
                ],
              ),
            )
          ]),
        ],
      ),
    );
  }
}
