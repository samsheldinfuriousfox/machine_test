import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_app/src/feature/image_list/data/models/model.dart';

class ApiClient extends GetxService {
  String baseUrl;
  late dio.Dio dioInstance;
  bool showInterceptor;
  ApiClient(this.baseUrl, this.showInterceptor) {
    dio.BaseOptions options = dio.BaseOptions(
      baseUrl: baseUrl,
    );
    dioInstance =
        dio.Dio(options) /* ..interceptors.add(alice.getDioInterceptor()) */;
  }

  Future<Either<EmptyResponseModel, T?>> get<T extends Models<dynamic>, R>(
    String path,
    T obj, {
    Map<String, dynamic>? queryParameters,
    bool noBodyRequired = false,
  }) async {
    try {
      dio.Response response = await dioInstance.get(path,
          options: dio.Options(
            headers: {
              // "Content-Type": 'application/json',
            },
          ),
          queryParameters: queryParameters);
      return _returnResponse(response, obj, noBodyRequired: noBodyRequired);
    } on SocketException {
      return left(EmptyResponseModel(
          code: 1001, status: "failure", msg: "No Internet"));
    } on dio.DioError catch (e) {
      if (e.error is SocketException) {
        return left(
            EmptyResponseModel(code: 1000, status: "failure", msg: e.message));
      } else if (e.response != null) {
        return _returnResponse(e.response, obj);
      } else {
        return left(
            EmptyResponseModel(code: 1000, status: "failure", msg: e.message));
      }
    } catch (e) {
      return left(
          EmptyResponseModel(code: 1000, status: "failure", msg: e.toString()));
    }
  }

  Future<Either<EmptyResponseModel, T?>>
      _returnResponse<T extends Models<dynamic>, R>(
          dio.Response? response, T? obj,
          {bool isAutorised = true, bool noBodyRequired = false}) async {
    if (noBodyRequired) {
      return right(null);
    } else {
      Map innerResponse = {};
      var responseJson = response?.data;
      if (!isAutorised) {
        //  innerResponse = json.decode(responseJson["response"]);
      }
      switch (response?.statusCode) {
        case 200:
          try {
            return right(obj?.fromJson(responseJson));
          } catch (_) {
            return left(EmptyResponseModel(
                code: 100, status: "failure", msg: "Data type mismatch"));
          }
        case 201:
          return right(obj?.fromJson(responseJson));

        case 204:
          return right(null);
        case 400:
          return left(EmptyResponseModel(
              code: 400,
              status: "failure",
              msg: response?.statusMessage ?? "error"));
        case 401:
          {
            return left(EmptyResponseModel(
                code: 401,
                status: "failure",
                msg: response?.statusMessage ?? "error"));
          }
        case 403:
          if (isAutorised) {
            return left(EmptyResponseModel(
                code: 401,
                status: "failure",
                msg: response?.statusMessage ??
                    innerResponse["msg"] ??
                    "error"));
          } else {
            return left(EmptyResponseModel(
                code: 401,
                status: "failure",
                msg: innerResponse["error_description"] ?? "error"));
          }
        case 404:
          return left(EmptyResponseModel(
              code: 404,
              status: "failure",
              msg: response?.statusMessage ??
                  innerResponse["msg"] ??
                  "Not found"));
        case 406:
          return left(EmptyResponseModel(
              code: 406,
              status: "failure",
              msg: response?.statusMessage ?? innerResponse["msg"] ?? 'error'));
        case 500:
          return left(EmptyResponseModel(
              code: 500,
              status: "failure",
              msg: innerResponse["msg"] ??
                  response?.statusMessage ??
                  'Server error'));

        default:
          return left(EmptyResponseModel(
              code: 1000, status: "failure", msg: 'Unknown error'));
      }
    }
  } //400,401,403,406
}
