import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibec_test/network/repository/global_repository.dart';
import 'package:ibec_test/screens/bottom_navigation_bar/cubit/bottom_nav_bar_cubit.dart';
import 'package:ibec_test/screens/top_headlines_screen/bloc/bloc_top_headlines.dart';

///Providers for global blocs
class TopLevelBlocs extends StatelessWidget {
  final Widget child;

  const TopLevelBlocs({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavBarCubit>(
          create: (context) => BottomNavBarCubit(),
        ),
        BlocProvider<BlocTopHeadlinesScreen>(
            create: (context) => BlocTopHeadlinesScreen(
                repository: context.read<GlobalRepository>())
              ..add(EventInitialTopHeadlines())),
      ],
      child: child,
    );
  }
}
