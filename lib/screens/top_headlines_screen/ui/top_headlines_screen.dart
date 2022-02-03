// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibec_test/constants/app_colors.dart';
import 'package:ibec_test/constants/app_text_styles.dart';
import 'package:ibec_test/network/models/dto_models/response/top_headlines_response.dart';
import 'package:ibec_test/screens/detailed_news_screen/ui/detailed_news_screen.dart';
import 'package:ibec_test/screens/top_headlines_screen/bloc/bloc_top_headlines.dart';
import 'package:ibec_test/widgets/app_router.dart';
import 'package:ibec_test/widgets/custom_app_bar.dart';

class TopHeadlinesScreen extends StatelessWidget {
  TopHeadlinesScreen({Key? key}) : super(key: key);
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // backgroundColor: AppColors.backgroundShade,
      // appBar: const CustomAppBar(
      //   height: 100,
      //   title: "Top headlines",
      //   bottom: _BuildBottom(),
      // ),
      slivers: [
        const SliverAppBar(
          pinned: true,
          forceElevated: true,
          title: Text(
            "Top headlines",
            style: AppTextStyles.s20w600,
          ),
        ),
        SliverFillRemaining(
          child: BlocConsumer<BlocTopHeadlinesScreen, StateBlocTopHeadlines>(
              builder: (context, state) {
                if (state is StateTopHeadlinesLoad) {
                  isLoading = false;
                  if (state.newsArticles.isEmpty) {
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
                            .read<BlocTopHeadlinesScreen>()
                            .add(EventInitialTopHeadlines(isRefresh: true));
                      },
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification notification) {
                          if (!isLoading &&
                              notification.metrics.pixels ==
                                  notification.metrics.maxScrollExtent) {
                            isLoading = true;
                            context
                                .read<BlocTopHeadlinesScreen>()
                                .add(EventInitialTopHeadlines());
                          }
                          return false;
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                addAutomaticKeepAlives: true,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 18),
                                itemCount: state.newsArticles.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () => AppRouter.push(
                                      context,
                                      DetailedNewsScreen(
                                          newsDetails:
                                              state.newsArticles[index]),
                                      rootNavigator: true,
                                    ),
                                    child: _BuildNewsPreview(
                                        article: state.newsArticles[index]),
                                  );
                                },
                              ),
                              if (state.isLoading)
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 85.0),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                )
                              else
                                const SizedBox(
                                  height: 85,
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
    );
  }
}

class _BuildBottom extends StatefulWidget implements PreferredSizeWidget {
  const _BuildBottom({Key? key}) : super(key: key);

  @override
  State<_BuildBottom> createState() => _BuildBottomState();

  @override
  Size get preferredSize => const Size.fromHeight(0);
}

class _BuildBottomState extends State<_BuildBottom> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlocTopHeadlinesScreen, StateBlocTopHeadlines>(
        builder: (context, state) {
          if (state is StateTopHeadlinesLoad) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: DropdownButtonFormField(
                  value: selectedValue,
                  decoration: const InputDecoration(
                    isDense: false,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  // value: state.categories.first,
                  hint: const Text("Choose your category"),
                  items: state.categories.map((String val) {
                    return DropdownMenuItem(
                      child: Text(val),
                      value: val,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value.toString();
                    });
                    context.read<BlocTopHeadlinesScreen>().add(
                        EventInitialTopHeadlines(
                            isRefresh: true, category: value.toString()));
                  }),
            );
          }
          return const SizedBox();
        },
        listener: (context, state) {});
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
          ),
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
