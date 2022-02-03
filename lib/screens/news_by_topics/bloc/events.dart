part of 'bloc_topic_news.dart';

@immutable
abstract class EventBlocTopicNews {}

class EventInitialTopicNews extends EventBlocTopicNews {
  final bool isRefresh;

  EventInitialTopicNews({
    this.isRefresh = false,
  });
}
