import '../../../../core/_core_exports.dart';

class SaveRepository {
  Product product = Product();
  Future<bool> updateProduct(
      {BaseModel? paramModel, required BaseModel productModel}) async {
    await BaseService.instance.post(ApplicationConstants.NETWORKAPSAVE,
        param: productModel, model: product);
    // ignore: unnecessary_null_comparison
    return true;
  }
}
