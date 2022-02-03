part of 'bloc_top_headlines.dart';

@immutable
abstract class EventBlocTopHeadlines {}

class EventInitialTopHeadlines extends EventBlocTopHeadlines {
  final bool isRefresh;
  final String? category;
  EventInitialTopHeadlines({
    this.isRefresh = false,
    this.category,
  });
}
