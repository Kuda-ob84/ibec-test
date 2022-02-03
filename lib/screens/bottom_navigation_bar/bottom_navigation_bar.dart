import 'package:ibec_test/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibec_test/screens/top_headlines_screen/ui/top_headlines_screen.dart';
import 'cubit/bottom_nav_bar_cubit.dart';
import 'custom_animated_bottom_bar.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        if (state is BottomNavBarInitial) {
          return WillPopScope(
            onWillPop: () async {
              bool isPop = true;
              isPop = await navigatorKeys[state.currentPageIndex]
                      .currentState
                      ?.maybePop() ??
                  false;
              return !isPop;
            },
            child: Scaffold(
              body: Stack(
                children: [
                  IndexedStack(
                    index: state.currentPageIndex,
                    children: [
                      Navigator(
                        key: navigatorKeys[0],
                        onGenerateRoute: (route) => MaterialPageRoute(
                          builder: (context) => TopHeadlinesScreen(),
                        ),
                      ),
                      Navigator(
                        key: navigatorKeys[1],
                        onGenerateRoute: (route) => MaterialPageRoute(
                          builder: (context) => Container(),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 50,
                    right: 50,
                    bottom: 22,
                    child: Container(
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(16, 51, 115, 0.2),
                              blurRadius: 30,
                              offset: Offset(0, 0),
                            )
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CustomAnimatedBottomBar(
                          containerHeight: 60,
                          backgroundColor: Colors.white,
                          selectedIndex: state.currentPageIndex,
                          showElevation: true,
                          itemCornerRadius: 24,
                          curve: Curves.easeIn,
                          onItemSelected: (index) {
                            context
                                .read<BottomNavBarCubit>()
                                .changeCurrentPage(index);
                          },
                          items: [
                            BottomNavBarItem(
                              icon: const Icon(Icons.list),
                              title: "Top news",
                              activeColor: AppColors.background,
                              inactiveColor: AppColors.lightBlue,
                              textAlign: TextAlign.center,
                            ),
                            BottomNavBarItem(
                              icon: const Icon(Icons.search),
                              title: "Search news",
                              activeColor: AppColors.background,
                              inactiveColor: AppColors.lightBlue,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
