import "dart:convert";

import "package:paperweft/core/api/api_model.dart";
import "package:paperweft/core/environtment/app_environment.dart";
import "package:dio/dio.dart";

class ApiClient {
  ApiClient();

  Dio dio = Dio(
    BaseOptions(
      baseUrl: BaseApiUrl.envApiUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      receiveDataWhenStatusError: true,
      followRedirects: true,
    ),
  );

  /// Post Data
  /// [type] auth | general
  /// default general
  Future<Response> postData({
    String parameter = "",
    String contentType = "json",
    dynamic data = const {},
    String customBaseApiUrl = "",
    required ApiModel apiModel,
  }) async {
    Options optionsRequest = Options(
        method: apiModel.method, // *GET, POST, PUT, DELETE, etc
        responseType: ResponseType.json,
        headers: {
          'Host': AppEnvironment.enviromentServer.replaceAll("/", ""),
          'Accept': 'application/text',
          'Content-Type': 'application/text',
        }..addAll(apiModel.customHeader));

    try {
      final response = await dio.request(
        Uri.encodeFull(apiModel.url.replaceAll("{parameter}", parameter)),
        data: jsonEncode(data),
        options: optionsRequest,
      );
      return response;
    } on DioError catch (ex) {
      Response response = Response(
        requestOptions: ex.requestOptions,
        data: ex.response!.data,
        statusCode: ex.response!.statusCode,
      );

      throw (response);
    }
  }
}
