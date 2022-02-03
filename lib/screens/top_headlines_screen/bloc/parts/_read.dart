part of '../bloc_top_headlines.dart';

extension Read on BlocTopHeadlinesScreen {
  Future<void> _read(EventInitialTopHeadlines event,
      Emitter<StateBlocTopHeadlines> emit) async {
    try {
      if (event.isRefresh) {
        emit(StateTopHeadlinesLoading());
        page = 0;
        isLoading = true;
        articles.clear();
      }
      page++;
      TopHeadlinesResponse headlines = await repository.getTopHeadlines(page,
          category: event.category ?? "");
      if ((headlines.articles ?? []).isNotEmpty) {
        articles.addAll(headlines.articles!.toList());
        articles.removeWhere((element) =>
            (element.urlToImage ?? "").isEmpty ||
            (element.title ?? "").isEmpty ||
            (element.description ?? "").isEmpty);
        emit(
          StateTopHeadlinesLoad(
            newsArticles: articles,
            isLoading: headlines.articles!.length == 10,
            categories: categories,
          ),
        );
      } else {
        isLoading = false;
        emit(StateTopHeadlinesLoad(
          newsArticles: articles,
          isLoading: false,
          categories: categories,
        ));
      }
      print(headlines);
    } catch (e) {
      isLoading = false;
      emit(StateTopHeadlinesLoad(
        newsArticles: articles,
        isLoading: false,
        categories: categories,
      ));

      rethrow;
    }
  }
}
