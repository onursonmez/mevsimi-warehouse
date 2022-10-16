import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mevsimiwarehouse/generated/locale_keys.g.dart';
import 'package:provider/provider.dart';
import 'package:mevsimiwarehouse/core/_core_exports.dart';

import '../../../core/shared_widgets/bottom_showsheet.dart';
import '../../_view_exports.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<LoginViewModel>(context, listen: false).initPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Consumer<LoginViewModel>(
            builder: (context, loginViewModel, child) {
              return GestureDetector(
                child: SizedBox(
                  width: context.width,
                  height: context.height,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenSize().getWidthPercent(0.12)),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        Row(
                          children: [
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                showCustomBottomSheet(
                                    title:
                                        "Çıkış Yapmak İstediğinizden Emin Misiniz",
                                    height: ScreenSize().getHeightPercent(.3),
                                    child: Column(
                                      children: [
                                        CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            child: Container(
                                              color: AppColors.appGrey
                                                  .withOpacity(.03),
                                              width: double.infinity,
                                              height: ScreenSize()
                                                  .getWidthPercent(.15),
                                              child: Center(
                                                child: Text(
                                                  "Evet",
                                                  style: AppTextStyles
                                                      .button16Regular,
                                                ),
                                              ),
                                            ),
                                            onPressed: () async {
                                              Navigator.pop(context);

                                              Provider.of<IpConnectionViewModel>(
                                                      context,
                                                      listen: false)
                                                  .clearViewModel();
                                              await LocaleManager.instance
                                                  .setStringValue(
                                                      PreferencesKeys.IP_INFO,
                                                      "");
                                              NavigationService.instance
                                                  .navigateToPage(
                                                      path: NavigationConstants
                                                          .IP_VIEW);
                                            }),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            child: Container(
                                              color: AppColors.appGrey
                                                  .withOpacity(.03),
                                              width: double.infinity,
                                              height: ScreenSize()
                                                  .getWidthPercent(.15),
                                              child: Center(
                                                child: Text(
                                                  "Hayır",
                                                  style: AppTextStyles
                                                      .button16Regular,
                                                ),
                                              ),
                                            ),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                            })
                                      ],
                                    ));
                              },
                              child: SvgIcons(
                                path: ImageConstants.instance.getBackButtonIcon,
                                size: 0.10,
                              ),
                            ),
                          ],
                        ),
                        SvgIcons(
                            path: ImageConstants.instance.getFullLogoImage,
                            size: 0.36),
                        SizedBox(
                          height: ScreenSize().getWidthPercent(0.05),
                        ),
                        GlobalInputArea(
                          hideShowText: false,
                          secretText: false,
                          txtController: loginViewModel.txtUserNameController,
                          txtFocusNode: loginViewModel.focusName,
                          txtHintText: LocaleKeys.eMail.locale,
                          onSubmitFunction: (value) {
                            loginViewModel
                                .focusInput(loginViewModel.focusPassword);
                            //loginViewModel.focusPassword.requestFocus();
                          },
                        ),
                        SizedBox(
                          height: context.mediumValue,
                        ),
                        GlobalInputArea(
                          hideShowText: loginViewModel.hideText,
                          secretText: true,
                          txtController: loginViewModel.txtPasswordController,
                          txtFocusNode: loginViewModel.focusPassword,
                          txtHintText: LocaleKeys.password.locale,
                          sufixButtonFunction: () {
                            loginViewModel.changePasswordHide();
                          },
                        ),
                        SizedBox(
                          height: context.height * .3,
                        ),
                        StandartButton(
                          btnFunction: () {
                            loginViewModel.fectLogin();
                          },
                          bacgraundColor: AppColors.generalBlueColor,
                          buttonText: LocaleKeys.login.locale,
                          buttonTextColor: AppColors.appWhite,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).padding.bottom +
                              context.mediumValue,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        onWillPop: () async {
          Provider.of<LoginViewModel>(context, listen: false).dispose();
          NavigationService.instance
              .navigateToPage(path: NavigationConstants.IP_VIEW);
          return false;
        });
  }
}
