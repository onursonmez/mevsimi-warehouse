import '../../../../core/_core_exports.dart';

class LandingRepository {
  Future<List<Product>?> fetchDeliverJob() async {
    ProductResult productResult = ProductResult();
    ApplicationConstants.NETWORKAPIGETDELIVERJOBLIST =
        'warehouse/order_item/list?field=id&order=descend&page=1&pageSize=1000&${ApplicationConstants.dateTimeHeader}';
    await BaseService.instance.get(
        ApplicationConstants.NETWORKAPIGETDELIVERJOBLIST,
        model: productResult);
    return productResult.product ?? [];
  }
}
