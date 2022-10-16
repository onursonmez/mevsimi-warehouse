// ignore_for_file: non_constant_identifier_names, constant_identifier_names

class ApplicationConstants {
  static bool? connection;
  static const NETWORKTOKENNAME = 'X-AUTH-TOKEN';
  static const LANG_ASSET_PATH = 'assets/language';
  static String NETWORKAPIBASEURL = 'https://devapi.mevsimi.com';
  static String NETWORKAPPTOKEN = "";
  static const NETWORKAPILOGIN = 'v2/user/login';
  static const NETWORKAPIIPCONTROL = 'warehouse/app/signal';
  static String NETWORKAPIGETDELIVERJOBLIST =
      'warehouse/order_item/list?field=id&order=descend&page=1&pageSize=1000&$dateTimeHeader';
  static const NETWORKAPSAVE = "warehouse/order_item/update";
  static String dateTimeHeader =
      "deliveryAt[0]=${DateTime.now().toString().substring(0, 10)}&deliveryAt[1]=${DateTime.now().toString().substring(0, 10)}";
}
