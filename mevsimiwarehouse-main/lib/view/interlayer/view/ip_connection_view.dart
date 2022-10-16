import 'package:flutter/material.dart';
import 'package:mevsimiwarehouse/generated/locale_keys.g.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';
import 'package:mevsimiwarehouse/view/_view_exports.dart';
import 'package:provider/provider.dart';

class IpLayerView extends StatefulWidget {
  const IpLayerView({Key? key}) : super(key: key);

  @override
  State<IpLayerView> createState() => _IpLayerViewState();
}

class _IpLayerViewState extends State<IpLayerView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<IpConnectionViewModel>(context, listen: false).initPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: !Provider.of<IpConnectionViewModel>(context, listen: true)
                  .isLoad
              ? GestureDetector(
                  onTap: () => context.removeFocus(context),
                  child: Center(
                    child: Consumer<IpConnectionViewModel>(
                      builder: (context, ipConnectionViewModel, child) =>
                          Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            GlobalInputArea(
                              txtController: ipConnectionViewModel
                                  .textIpInformationController,
                              txtFocusNode:
                                  ipConnectionViewModel.focusIpInformation,
                              hideShowText: false,
                              secretText: false,
                              txtHintText:
                                  LocaleKeys.connectionInformation.locale,
                            ),
                            StandartButton(
                              buttonText: LocaleKeys.systemConnect.locale,
                              buttonTextColor: AppColors.appWhite,
                              bacgraundColor: AppColors.generalBlueColor,
                              btnFunction: () {
                                ipConnectionViewModel.getIpConnection();
                              },
                            )
                          ]),
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(color: context.appGreen),
                ),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
