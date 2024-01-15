import 'package:paperweft/core/api/api_model.dart';

class ApiConstant {
  static ApiModel validateLogin = ApiModel(
      url: 'search?term=jack+johnson&entity=musicVideo{parameter}',
      method: ApiMethodType.get,
      requiredToken: false,
      description: 'get Preview');
}
