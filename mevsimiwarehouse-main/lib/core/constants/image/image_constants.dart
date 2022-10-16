class ImageConstants {
  static ImageConstants? _instace;

  static ImageConstants get instance => _instace ??= ImageConstants._init();

  ImageConstants._init();

  String get getLogoTextImage => toImageSvg('logo_text');
  String get getLogo => toImageSvg('logo');
  String get getProductSavedImage => toImageSvg('product_saved_image');
  String get getQrImage => toImageSvg('qr_image');
  String get getRelationResualtImage => toImageSvg('relation_resualt_image');
  String get getPng => toImageSvg('login_image');
  String get getFullLogoImage => toImageSvg('full_logo_image');
  String get loginImage => toImageSvg('login_image');
  String get appBarIamge => toImageSvg('appbar_image');

  String get getApiCloudIcon => toIconSvg('api_cloud_icon');
  String get orderNumberIcon => toIconSvg('order_number');
  String get getBackButtonIcon => toIconSvg('back_button_icon');
  String get getBarcodeIcon => toIconSvg('barcode_icon');
  String get getBocIcon => toIconSvg('box_icon');
  String get getDrawerButtonIcon => toIconSvg('drawer_button_icon');
  String get getEyesIcon => toIconSvg('eyes_icon');
  String get getShelfIcon => toIconSvg('shelf_icon');
  String get toEmptyBox => toIconPng('emptybox');

  String get getArtichoke => toIconVagetable('artichoke');
  String get getAubergine => toIconVagetable('aubergine');
  String get getBean => toIconVagetable('bean');
  String get getCabbage => toIconVagetable('cabbage');
  String get getCarrot => toIconVagetable('carrot');
  String get getCherry => toIconVagetable('cherry');
  String get getCucumber => toIconVagetable('cucumber');
  String get getGrapes => toIconVagetable('artichoke');
  String get getGreenPepper => toIconVagetable('green-pepper');
  String get getMelon => toIconVagetable('melon');
  String get getOnion => toIconVagetable('onion');
  String get getPeach => toIconVagetable('peach');
  String get getPear => toIconVagetable('pear');
  String get getPotato => toIconVagetable('potato');
  String get getSpice => toIconVagetable('spice');
  String get getStrawberry => toIconVagetable('strawberry');
  String get getTomato => toIconVagetable('tomato');
  String get getWaterMelon => toIconVagetable('water-melon');
  String get getVegetables => toIconVagetable('vegetables');

  String toImageSvg(String name) => 'assets/images/$name.svg';
  String toIconPng(String name) => 'assets/icons/$name.png';
  String toIconSvg(String name) => 'assets/icons/$name.svg';
  String toIconVagetable(String name) => 'assets/vegetable/$name.png';
}
