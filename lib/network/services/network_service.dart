import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ibec_test/network/dio_wrapper/dio_wrapper.dart';
import 'package:ibec_test/network/models/dto_models/encodable.dart';
import 'package:ibec_test/network/models/dto_models/response/top_headlines_response.dart';

class NetworkService {
  late final DioWrapper _dioWrapper;
  String apiKey = "e70e4d5cc04a4353b143a96a2d032bff";
  void init(
    DioWrapper dioService,
  ) {
    _dioWrapper = dioService;
  }

  Future<TopHeadlinesResponse> getTopHeadlines(int page, String category) async {
    Map<String, dynamic> queryParameters = {
      "apiKey": apiKey,
      "language": "en",
      "page": page,
      "pageSize": 10,
    };
    if(category.isNotEmpty){
      queryParameters["category"] = category;
    }
    var response = await _dioWrapper.sendRequest(
      path:
          "top-headlines",
      queryParameters: queryParameters,
      method: NetworkMethod.get,
    );
    return topHeadlinesResponseFromJson(json.encode(response.data));
  }

  Future<TopHeadlinesResponse> searchNews(
      int page, String search) async {
    Map<String, dynamic> queryParameters = {
      "apiKey": apiKey,
      "page": page,
      "pageSize": 10,
      "q": search,
    };
    var response = await _dioWrapper.sendRequest(
      path: "everything",
      queryParameters: queryParameters,
      method: NetworkMethod.get,
    );
    return topHeadlinesResponseFromJson(json.encode(response.data));
  }
}
