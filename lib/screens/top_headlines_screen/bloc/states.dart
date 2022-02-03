part of 'bloc_top_headlines.dart';

@immutable
abstract class StateBlocTopHeadlines {}

class StateTopHeadlinesLoading extends StateBlocTopHeadlines {}

class StateTopHeadlinesLoad extends StateBlocTopHeadlines {
  final List<Article> newsArticles;
  final bool isLoading;
  final List<String> categories;

  StateTopHeadlinesLoad({
    required this.newsArticles,
    required this.isLoading,
    required this.categories,
  });
}
