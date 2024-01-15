import 'package:paperweft/core/environtment/app_environment.dart';

class ApiMethodType {
  static const String get = "GET";
  static const String post = "POST";
  static const String put = "PUT";
  static const String delete = "DELETE";
}

class BaseApiUrl {
  static String envApiUrl = AppEnvironment.urlScheme +
      AppEnvironment.enviromentServer.replaceAll("/", "");
}

class ApiModel {
  final String url;
  final String method; // ApiMethodType Class
  final bool requiredToken;
  final Map<String, dynamic> customHeader;
  final String? description;
  final bool? isFormData;

  ApiModel({
    required this.url,
    required this.method,
    required this.requiredToken,
    this.customHeader = const {},
    this.description,
    this.isFormData,
  });
}
