import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mevsimiwarehouse/view/login/repository/login_repository.dart';

import '../../../core/_core_exports.dart';
import '../../_view_exports.dart';

class LoginViewModel extends ChangeNotifier {
  LoginRepository loginRepository = LoginRepository();
  late LoginParam loginParam = LoginParam();
  late Login login;
  TextEditingController txtUserNameController = TextEditingController();
  TextEditingController txtPasswordController = TextEditingController();
  bool isLoad = false;
  bool hideText = true;

  FocusNode focusName = FocusNode();
  FocusNode focusPassword = FocusNode();

  void changeIsload() {
    isLoad = !isLoad;
    notifyListeners();
  }

  Future<void> initPage() async {
       txtUserNameController.text = "";
      txtPasswordController.text = "";
    focusName.addListener(() {
      notifyListeners();
    });
    focusPassword.addListener(() {
      notifyListeners();
    });
    String _loginInfo = LocaleManager.instance
        .getStringValue(PreferencesKeys.LOGIN_INFORMATION);
    if (_loginInfo != "") {
      var loginJsonParam = jsonDecode(_loginInfo);
      if (loginJsonParam.isNotEmpty) {
        loginParam = LoginParam().fromJson(loginJsonParam);
        txtUserNameController.text = loginParam.email!;
        txtPasswordController.text = loginParam.password!;
        fectLogin();
      }
    }
  }
void clearViewModel(){
  txtPasswordController.clear();
  txtUserNameController.clear();
}
  void dispose() {
    focusName.dispose();
    focusPassword.dispose();
  }

  Future<void> fectLogin() async {
    login = Login();
    changeIsload();
    loginParam.email = txtUserNameController.text;
    loginParam.password = txtPasswordController.text;
    login = await loginRepository.fetchLogin(
        paramModel: loginParam, loginModel: login);
    changeIsload();
    if (login.token!.isNotEmpty) {
      String _localLogin = loginParam.toJson();
      LocaleManager.instance
          .setStringValue(PreferencesKeys.TOKEN, login.token!);
      LocaleManager.instance
          .setStringValue(PreferencesKeys.LOGIN_INFORMATION, _localLogin);
      ApplicationConstants.NETWORKAPPTOKEN = login.token!;
      // ignore: avoid_print
      print(login.token);
      nextPageButton();
    }
  }

  void focusInput(FocusNode focusNode) {
    focusNode.requestFocus();
  }

  void changePasswordHide() {
    hideText = !hideText;
    notifyListeners();
  }

  Future<void> nextPageButton() async {
    NavigationService.instance
        .navigateToPage(path: NavigationConstants.LANDING_PAGE);
  }
}
