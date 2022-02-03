import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibec_test/network/dio_wrapper/dio_wrapper.dart';
import 'package:ibec_test/network/repository/global_repository.dart';
import 'package:ibec_test/network/services/network_service.dart';
import 'package:provider/provider.dart';

class DependenciesProvider extends StatelessWidget {
  final Widget child;

  const DependenciesProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider(
          create: (_) => DioWrapper(),
        ),
        RepositoryProvider(
          create: (_) => GlobalRepository(),
        ),
        RepositoryProvider(
          create: (_) => NetworkService(),
        ),
      ],
      child: child,
    );
  }
}
