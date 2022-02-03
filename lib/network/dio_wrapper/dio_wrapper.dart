import 'dart:async';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:ibec_test/network/models/dto_models/encodable.dart';
import 'package:ibec_test/network/repository/global_repository.dart';

enum NetworkMethod { get, post, put, patch, delete }

class DioWrapper {
  final _dio = Dio();

  Future<void> init({
    String baseURL = '',
    required GlobalRepository globalRepository,
  }) async {
    _dio.options.baseUrl = baseURL;

    ///TODO must be removed
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };

    _dio.interceptors.requestLock.lock();
    _dio.interceptors.clear();
    _dio.options.connectTimeout = 40000;
    _dio.options.receiveTimeout = 40000;
    _dio.options.sendTimeout = 40000;
    _dio.options.responseType = ResponseType.json;

    _dio.interceptors.requestLock.unlock();
  }

  void changeBaseURL({required String url}) {
    _dio.options.baseUrl = url;
  }

  Future<Response> download(
    String urlPath,
    savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    data,
    Options? options,
  }) async {
    return await _dio.download(urlPath, savePath);
  }

  Future<dynamic> sendRequest({
    required String path,
    required NetworkMethod method,
    Encodable? request,
    FormData? formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool isUrlEncoded = true,
  }) async {
    final params = request == null
        ? (formData == null ? null : FormData.fromMap({}))
        : request.toJson();

    switch (method) {
      case NetworkMethod.get:
        final response = await _getRequest(
          path,
          method,
          queryParameters: queryParameters,
          isUrlEncoded: isUrlEncoded,
        );
        return response;
      case NetworkMethod.post:
        final response = formData == null
            ? await _postRequest(
                path,
                method,
                data: params,
                queryParameters: queryParameters,
                options: options,
              )
            : await _postFormData(
                path,
                formData,
                queryParameters: queryParameters,
              );
        return response;
      case NetworkMethod.put:
        final response = await _putRequest(
          path,
          method,
          data: params,
          queryParameters: queryParameters,
        );
        return response;
      case NetworkMethod.delete:
        final response = await _deleteRequest(
          path,
          method,
          data: params,
          queryParameters: queryParameters,
        );
        return response;
      case NetworkMethod.patch:
        final response = await _patchRequest(
          path,
          method,
          data: params,
          queryParameters: queryParameters,
        );
        return response;
      default:
        return null;
    }
  }

  Future<Response<dynamic>> _putRequest(
    String path,
    NetworkMethod method, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    var response = _dio.put(
      "$path",
      data: data,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response<dynamic>> _deleteRequest(
    String path,
    NetworkMethod method, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    var response = _dio.delete(
      "$path",
      data: data,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response<dynamic>> _postRequest(
    String path,
    NetworkMethod method, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var response = _dio.post(
      "$path",
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response;
  }

  Future<Response<dynamic>> _patchRequest(
    String path,
    NetworkMethod method, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    var response = _dio.patch(
      "$path",
      data: data,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response<dynamic>> _postFormData(
    String path,
    FormData data, {
    Map<String, dynamic>? queryParameters,
  }) async {
    var response = _dio.post(
      "$path",
      data: data,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response<dynamic>> _getRequest(
    String path,
    NetworkMethod method, {
    Map<String, dynamic>? queryParameters,
    bool isUrlEncoded = true,

    /// disables encoding of URI if false in accordance with header 'application/x-www-form-urlencoded'
  }) async {
    if (!isUrlEncoded && queryParameters != null) {
      path = path + '?' + _transformQueryParametersToString(queryParameters);
    }
    var response =
        _dio.get(path, queryParameters: isUrlEncoded ? queryParameters : null);
    return response;
  }

  String _transformQueryParametersToString(
      Map<String, dynamic> queryParameters) {
    String _query = '';
    queryParameters.forEach((key, value) {
      _query += '$key=${value.toString()}&';
    });
    return _query.substring(0, _query.length - 1);
  }
}
