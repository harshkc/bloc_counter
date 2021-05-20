import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:learning_bloc/counter/counter.dart';
import 'package:learning_bloc/counter/cubit/internet_cubit.dart';
import 'package:learning_bloc/l10n/l10n.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final Connectivity connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InternetCubit(connectivity: connectivity),
      child: MaterialApp(
        theme: ThemeData(
          accentColor: const Color(0xFF13B9FF),
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        ),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const CounterPage(),
      ),
    );
  }
}
