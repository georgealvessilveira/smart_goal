import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_goals/core/const/app_const.dart';
import 'package:smart_goals/core/module/core_module.dart';
import 'package:smart_goals/firebase_options.dart';
import 'package:smart_goals/module/auth/presenter/auth_module.dart';
import 'package:smart_goals/module/goal/presenter/goal_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module('/', module: GoalModule());
    r.module('/auth', module: AuthModule());
  }

  @override
  List<Module> get imports => [
        CoreModule(),
      ];
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appName,
      debugShowCheckedModeBanner: kDebugMode,
      localizationsDelegates: const [
        //LocalJsonLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          primary: Colors.teal,
          secondary: Colors.blueGrey,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: TextStyle(fontSize: 18.0),
          headlineMedium: TextStyle(fontSize: 16.0),
          headlineSmall: TextStyle(fontSize: 12.0),
        ),
      ),
      routerConfig: Modular.routerConfig,
    );
  }
}
