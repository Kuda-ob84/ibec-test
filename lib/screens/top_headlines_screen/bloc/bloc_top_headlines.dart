import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ibec_test/network/models/dto_models/response/top_headlines_response.dart';
import 'package:ibec_test/network/repository/global_repository.dart';
import 'package:meta/meta.dart';

part 'events.dart';
part 'states.dart';
part 'parts/_read.dart';

class BlocTopHeadlinesScreen extends Bloc<EventBlocTopHeadlines, StateBlocTopHeadlines> {
  BlocTopHeadlinesScreen({
    required this.repository,
}) : super(StateTopHeadlinesLoading()) {
    on<EventInitialTopHeadlines>(_read);
  }

  final GlobalRepository repository;
  bool isLoading = true;
  List<Article> articles = [];
  int page = 0;
  List<String> categories = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology",
  ];
}
