import 'package:ibec_test/screens/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ibec_test/screens/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:provider/src/provider.dart';

import 'main/dependency_initializer/dependency_initializer.dart';
import 'main/dependency_provider/dependency_provider.dart';
import 'main/top_level_blocs/top_level_blocs.dart';
import 'network/dio_wrapper/dio_wrapper.dart';
import 'network/repository/global_repository.dart';
import 'network/services/network_service.dart';

const String baseUrl = 'https://newsapi.org/v2/';

String get projectBaseUrl {
  if (kDebugMode) return baseUrl;
  return '';
}

void main() async {
  ///Global managers initialization
  Future<bool> _initialize(BuildContext context) async {
    try {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      await context.read<DioWrapper>().init(
            baseURL: projectBaseUrl,
            globalRepository: context.read<GlobalRepository>(),
          );
      context.read<NetworkService>().init(
            context.read<DioWrapper>(),
          );
      context.read<GlobalRepository>().init(
            context.read<NetworkService>(),
          );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
      }
    }
    return true;
  }

  runApp(
    DependenciesProvider(
      child: TopLevelBlocs(
        child: MaterialApp(
          title: 'iBEC Test',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
            ),
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Gilroy',
            textSelectionTheme: const TextSelectionThemeData().copyWith(
              cursorColor: Colors.black,
            ),
          ),
          home: DependenciesInitializer(
            loadingIndicatorScreen: const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            initializer: _initialize,
            child: BottomNavigationBarScreen(),
          ),
        ),
      ),
    ),
  );
}
