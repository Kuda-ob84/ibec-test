import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ibec_test/network/models/dto_models/response/top_headlines_response.dart';
import 'package:ibec_test/network/repository/global_repository.dart';
import 'package:meta/meta.dart';

part 'events.dart';

part 'states.dart';

part 'parts/search.dart';

class BlocTopicNews extends Bloc<EventBlocTopicNews, StateBlocTopicNews> {
  BlocTopicNews({
    required this.repository,
    required this.topic,
  }) : super(StateTopicNewsInitial()) {
    on<EventInitialTopicNews>(_search);
  }

  final GlobalRepository repository;
  final String topic;
  bool isLoading = true;
  List<Article> articles = [];
  int page = 0;
}
