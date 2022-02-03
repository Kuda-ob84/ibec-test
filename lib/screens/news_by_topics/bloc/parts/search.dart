part of '../bloc_topic_news.dart';

extension Search on BlocTopicNews {
  Future<void> _search(
      EventInitialTopicNews event, Emitter<StateBlocTopicNews> emit) async {
    try {
      if (event.isRefresh) {
        emit(StateTopicNewsInitial());
        page = 0;
        isLoading = true;
        articles.clear();
      }
      page++;
      TopHeadlinesResponse headlines = await repository.searchNews(page, topic);
      if ((headlines.articles ?? []).isNotEmpty) {
        articles.addAll(headlines.articles!.toList());
        articles.removeWhere((element) =>
            (element.urlToImage ?? "").isEmpty ||
            (element.title ?? "").isEmpty ||
            (element.description ?? "").isEmpty);
        emit(
          StateLoadTopicNews(
            articles: articles,
            isLoading: headlines.articles!.length == 10,
          ),
        );
      } else {
        isLoading = false;
        emit(StateLoadTopicNews(
          articles: articles,
          isLoading: false,
        ));
      }
    } catch (e) {
      isLoading = false;
      emit(StateLoadTopicNews(
        articles: articles,
        isLoading: false,
      ));
      rethrow;
    }
  }
}
