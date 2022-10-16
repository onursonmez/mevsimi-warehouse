import '../../../core/_core_exports.dart';
import '../../_view_exports.dart';

class LoginRepository {
  Future<Login> fetchLogin(
      {required BaseModel paramModel, required BaseModel loginModel}) async {
    return await BaseService.instance.post(ApplicationConstants.NETWORKAPILOGIN,
        model: loginModel, param: paramModel);
  }
}
