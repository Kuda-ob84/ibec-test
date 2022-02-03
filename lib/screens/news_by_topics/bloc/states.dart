part of 'bloc_topic_news.dart';

@immutable
abstract class StateBlocTopicNews {}

class StateTopicNewsInitial extends StateBlocTopicNews {}

class StateLoadTopicNews extends StateBlocTopicNews {
  final List<Article> articles;
  final bool isLoading;

  StateLoadTopicNews({
    required this.articles,
    required this.isLoading,
  });
}
