import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'events.dart';
part 'states.dart';

class BlocTopicNews extends Bloc<EventBlocTopicNews, StateBlocTopicNews> {
  BlocTopicNews() : super(StateTopicNewsInitial()) {
    on<EventBlocTopicNews>((event, emit) {
      // TODO: implement event handler
    });
  }
}
