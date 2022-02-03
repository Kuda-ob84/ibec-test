import 'dart:io';

import 'package:ibec_test/network/models/dto_models/response/top_headlines_response.dart';
import 'package:ibec_test/network/services/network_service.dart';

class GlobalRepository {
  late final NetworkService _networkService;

  void init(NetworkService networkService) {
    _networkService = networkService;
  }

  Future<TopHeadlinesResponse> getTopHeadlines(int page, {String category = ""}) async {
    return _networkService.getTopHeadlines(page, category);
  }
}
