import 'package:flutter/material.dart';
import 'package:ibec_test/constants/app_text_styles.dart';
import 'package:ibec_test/network/models/dto_models/response/topic.dart';

class TopicNewsScreen extends StatefulWidget {
  const TopicNewsScreen({Key? key}) : super(key: key);

  @override
  State<TopicNewsScreen> createState() => _TopicNewsScreenState();
}

class _TopicNewsScreenState extends State<TopicNewsScreen> {
  late List<Topic> topics;

  @override
  void initState() {
    topics = [
      Topic(name: "Apple", image: ""),
      Topic(name: "Developing", image: ""),
      Topic(name: "Movies", image: ""),
      Topic(name: "Programming", image: ""),
      Topic(name: "Politics", image: ""),
      Topic(name: "Games", image: ""),
      Topic(name: "Apple", image: ""),
      Topic(name: "Apple", image: ""),
      Topic(name: "Apple", image: ""),
      Topic(name: "Apple", image: ""),
      Topic(name: "Apple", image: ""),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "Topics",
              style: AppTextStyles.s20w600,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [

              ],
            ),
          ),
        ],
      ),
    );
  }
}
