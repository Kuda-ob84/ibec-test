import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibec_test/constants/app_colors.dart';
import 'package:ibec_test/constants/app_text_styles.dart';
import 'package:ibec_test/network/models/dto_models/response/top_headlines_response.dart';
import 'package:ibec_test/network/repository/global_repository.dart';
import 'package:ibec_test/screens/detailed_news_screen/ui/detailed_news_screen.dart';
import 'package:ibec_test/screens/news_by_topics/bloc/bloc_topic_news.dart';
import 'package:ibec_test/widgets/app_router.dart';

class NewsPreviewScreen extends StatelessWidget {
  final String topic;

  NewsPreviewScreen({
    Key? key,
    required this.topic,
  }) : super(key: key);
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocTopicNews(
        repository: context.read<GlobalRepository>(),
        topic: topic,
      )..add(EventInitialTopicNews()),
      child: Scaffold(
        backgroundColor: AppColors.backgroundShade,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              forceElevated: true,
              elevation: 0,
              leading: IconButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              title: Text(
                topic,
                style: AppTextStyles.s20w600,
              ),
            ),
            SliverFillRemaining(
              child: BlocConsumer<BlocTopicNews, StateBlocTopicNews>(
                  builder: (context, state) {
                    if (state is StateLoadTopicNews) {
                      isLoading = false;
                      if (state.articles.isEmpty) {
                        return const Expanded(
                          child: Center(
                            child: Text("News are not exist"),
                          ),
                        );
                      } else {
                        return RefreshIndicator(
                          onRefresh: () async {
                            isLoading = false;
                            context
                                .read<BlocTopicNews>()
                                .add(EventInitialTopicNews(
                                  isRefresh: true,
                                ));
                          },
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification notification) {
                              if (!isLoading &&
                                  notification.metrics.pixels ==
                                      notification.metrics.maxScrollExtent) {
                                isLoading = true;
                                context
                                    .read<BlocTopicNews>()
                                    .add(EventInitialTopicNews(
                                    ));
                              }
                              return false;
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    addAutomaticKeepAlives: true,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 18),
                                    itemCount: state.articles.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () => AppRouter.push(
                                          context,
                                          DetailedNewsScreen(
                                              newsDetails:
                                                  state.articles[index]),
                                          rootNavigator: true,
                                        ),
                                        child: _BuildNewsPreview(
                                            article: state.articles[index]),
                                      );
                                    },
                                  ),
                                  if (state.isLoading)
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  listener: (context, state) {}),
            )
          ],
        ),
      ),
    );
  }
}

class _BuildNewsPreview extends StatelessWidget {
  final Article article;

  const _BuildNewsPreview({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(16, 51, 115, 0.2),
                  blurRadius: 10,
                  offset: Offset(0, 0),
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  children: [
                    Text(
                      article.title!.isEmpty ? "No data" : article.description!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s14w700,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      article.description!.isEmpty
                          ? "No data"
                          : article.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s14w400,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Image.network(
                  article.urlToImage!,
                  height: 70,
                  width: 100,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const SizedBox(
                      width: 100,
                      height: 70,
                      child: Center(
                        child: Icon(Icons.error),
                      ),
                    );
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? event) {
                    if (event == null) {
                      return child;
                    }
                    return const SizedBox(
                      width: 100,
                      height: 70,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              )
              // Padding(
              //   padding:
              //       const EdgeInsets.only(left: 18.0),
              //   child: CachedNetworkImage(
              //       width: 100,
              //       height: 70,
              //       imageUrl: state
              //           .newsArticles[index]
              //           .urlToImage!,
              //       placeholder: (context, __) {
              //         return const Padding(
              //           padding: EdgeInsets.all(10.0),
              //           child: Center(
              //               child:
              //                   CircularProgressIndicator()),
              //         );
              //       },
              //       errorWidget:
              //           (context, url, error) {
              //         return CircleAvatar(
              //           radius: 30.0,
              //           child: Text(
              //             'Н',
              //             style: AppTextStyles.s10
              //                 .copyWith(
              //                     color: Colors.white,
              //                     fontSize: 32),
              //           ),
              //         );
              //       },
              //       imageBuilder:
              //           (context, imageProvider) {
              //         return Container(
              //           decoration: BoxDecoration(
              //             image: DecorationImage(
              //                 image: imageProvider,
              //                 fit: BoxFit.cover,
              //                 colorFilter:
              //                     ColorFilter.mode(
              //                         Colors.red,
              //                         BlendMode
              //                             .colorBurn)),
              //           ),
              //         );
              //       }),
              // )
            ],
          )),
    );
  }
}
