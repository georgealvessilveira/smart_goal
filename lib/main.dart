import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_goals/core/const/app_const.dart';
import 'package:smart_goals/modules/auth/presenter/auth_module.dart';
import 'package:smart_goals/modules/goal/presenter/goal_module.dart';
import 'package:smart_goals/modules/profile/presenter/profile_module.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 9098);
  }

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
    r.module('/profile', module: ProfileModule());
  }
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
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
          secondary: Colors.deepPurpleAccent,
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
