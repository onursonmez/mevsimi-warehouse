import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/_core_exports.dart';

class IpConnectionViewModel extends ChangeNotifier {
  late TextEditingController textIpInformationController =
      TextEditingController();
  late FocusNode focusIpInformation = FocusNode();
  bool isLoad = false;
  void changeIsLoad() {
    isLoad = !isLoad;
    notifyListeners();
  }

  Future<void> initPage() async {
    await PermissionUtil().getPermission(Permission.storage);
    String _ip;
    _ip = LocaleManager.instance.getStringValue(PreferencesKeys.IP_INFO);
    if (_ip.isNotEmpty) {
      textIpInformationController.text = _ip;
      getIpConnection();
    }
  }
void clearViewModel(){
  textIpInformationController.clear();
}
  Future<void> getIpConnection() async {
    DynmicModel _dynmicModel = DynmicModel();
    ApplicationConstants.NETWORKAPIBASEURL = textIpInformationController.text;
    changeIsLoad();
    if (await BaseService.instance.get(ApplicationConstants.NETWORKAPIIPCONTROL,
            model: _dynmicModel) !=
        null) {
      LocaleManager.instance.setStringValue(
          PreferencesKeys.IP_INFO, textIpInformationController.text);
      changeIsLoad();
      nextPageButton();
      return;
    }

    changeIsLoad();
  }

  Future<void> nextPageButton() async {
    return NavigationService.instance
        .navigateToPage(path: NavigationConstants.LOGIN);
  }
}
