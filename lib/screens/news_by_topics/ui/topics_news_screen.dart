import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ibec_test/constants/app_text_styles.dart';
import 'package:ibec_test/network/models/dto_models/response/topic.dart';
import 'package:ibec_test/widgets/app_router.dart';
import 'package:ibec_test/widgets/main_text_field/app_text_field.dart';

import 'news_preview_screen.dart';

class TopicNewsScreen extends StatefulWidget {
  const TopicNewsScreen({Key? key}) : super(key: key);

  @override
  State<TopicNewsScreen> createState() => _TopicNewsScreenState();
}

class _TopicNewsScreenState extends State<TopicNewsScreen> {
  late List<Topic> topics;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    topics = [
      Topic(name: "Apple", image: "assets/images/png/apple.png"),
      Topic(name: "Programming", image: "assets/images/png/programming.png"),
      Topic(name: "Movies", image: "assets/images/png/movies.png"),
      Topic(name: "Politics", image: "assets/images/png/politics.png"),
      Topic(name: "Games", image: "assets/images/png/games.png"),
      Topic(name: "Ecology", image: "assets/images/png/ecology.png"),
    ];
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Topics",
          style: AppTextStyles.s20w600,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 18,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppTextField(
                hintText: "Search",
                controller: searchController,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => AppRouter.push(
                      context, NewsPreviewScreen(topic: searchController.text), rootNavigator: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Column(
                  children: topics.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: InkWell(
                        onTap: () => AppRouter.push(
                            context, NewsPreviewScreen(topic: e.name!), rootNavigator: true),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage(e.image!),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30.0, left: 30),
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  e.name!,
                                  style: AppTextStyles.pLarge.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 85,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
