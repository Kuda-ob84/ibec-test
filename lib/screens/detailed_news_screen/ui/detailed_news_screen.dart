import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ibec_test/constants/app_colors.dart';
import 'package:ibec_test/constants/app_text_styles.dart';
import 'package:ibec_test/network/models/dto_models/response/top_headlines_response.dart';
import 'package:ibec_test/widgets/app_router.dart';
import 'package:ibec_test/widgets/custom_app_bar.dart';
import 'package:intl/intl.dart';

class DetailedNewsScreen extends StatelessWidget {
  final Article newsDetails;

  const DetailedNewsScreen({
    Key? key,
    required this.newsDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundShade,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: 280.0,
              toolbarHeight: 190,
              floating: true,
              pinned: true,
              leading: SizedBox(),
              snap: true,
              actionsIconTheme: IconThemeData(opacity: 0.0),
              flexibleSpace: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: SizedBox(
                  height: 380,
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        newsDetails.urlToImage!,
                        width: double.infinity,
                        height: 360,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Center(
                            child: Image.asset(
                                'assets/icons_png/ic_image_splash_gray.png',
                                height: 60,
                                width: 60),
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
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 1.5,
                              sigmaY: 1.5,
                            ),
                            child: Container(
                              // the size where the blurring starts
                              height: 130,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 30,
                          left: 25,
                          right: 25,
                          child: Text(
                            newsDetails.title ?? "No title",
                            style: AppTextStyles.s22.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.background,
                            ),
                          )),
                      Positioned(
                        top: 30,
                        left: 10,
                        child: IconButton(
                          onPressed: () =>
                              Navigator.of(context, rootNavigator: true).pop(),
                          icon: Center(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.backgroundShade,
                              ),
                              child: Center(child: Icon(Icons.arrow_back)),
                            ),
                          ),
                        ),
                      ),
                      // Positioned(
                      //   bottom: 0,
                      //   top: 360,
                      //   right: 0,
                      //   left: 0,
                      //   child: BackdropFilter(
                      //     filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      //     child: Container(
                      //       height: 30,
                      //       decoration:
                      //           BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      //     ),
                      //   ),
                      // ),
                      // Positioned(
                      //   bottom: 0,
                      //   child: Container(
                      //       width: MediaQuery.of(context).size.width,
                      //       height: 180,
                      //       decoration: BoxDecoration(
                      //         color: Colors.black.withOpacity(0.28),
                      //       )),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.backgroundGrey,
                    ),
                    child: Text(
                      newsDetails.author ?? "No author",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.background,
                    ),
                    child: Text(
                      DateFormat("MMM. dd. yyyy")
                          .format(newsDetails.publishedAt ?? DateTime.now()),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(0
                height: 20,
              ),
              Text(
                newsDetails.description ?? "No description",
                style: AppTextStyles.pLarge
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                newsDetails.content ?? "No description",
                style: AppTextStyles.pLarge
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
