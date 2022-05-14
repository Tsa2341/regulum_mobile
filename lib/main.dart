import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:regulum/constants/themes.dart';
import 'package:regulum/screens/on_board_congratulation.screen.dart';
import 'package:regulum/screens/on_board_credentails.screen.dart';
import 'package:regulum/screens/on_board_home.screen.dart';
import 'package:regulum/screens/on_board_profile.srcreen.dart';
import 'package:regulum/screens/on_board_sign_in.screen.dart';

Future main() async {
  await dotenv.load(fileName: '.env');

  await Hive.initFlutter();
  await Hive.openBox<Map>('settings');
  await Hive.openBox('random');
  await Hive.openBox('user');

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: const Color(0xFFA5CC00)));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class OnBoardHomeCredentialsPageArguments {
  OnBoardHomeCredentialsPageArguments({required this.height});

  double height;
}

/// My Main app that runns on every time the first
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: FutureBuilder(
        future: Future(() async {
          Box randomBox = Hive.box("random");
          if (randomBox.get("initialized") == null) await randomBox.put("initialized", 1);

          log(randomBox.get("initialized").toString());
        }),
        builder: (context, snapshot) {
          Box randomBox = Hive.box("random");
          if (randomBox.get("initialized") != true) {
            return const OnBoardApp();
          } else {
            return const MainApp();
          }
        },
      ),
    );
  }
}

/// on boarding pages we see before starting using the app(when we install the app)
class OnBoardApp extends StatelessWidget {
  const OnBoardApp({Key? key}) : super(key: key);

  String _getInitialRoute() {
    Box randomBox = Hive.box('random');

    switch (randomBox.get('initialized')) {
      case OnBoardHome.route:
        return OnBoardHome.route;
      case OnBoardCredentials.route:
        return OnBoardCredentials.route;
      case OnBoardLogin.route:
        return OnBoardLogin.route;
      case OnBoardProfile.route:
        return OnBoardProfile.route;
      case OnBoardCongratulation.route:
        return OnBoardCongratulation.route;
      default:
        return OnBoardHome.route;
    }
  }

  Widget _onBoardHomePageFunc(RouteSettings settings) {
    // OnBoardHomeCredentialsPageArguments height = settings.arguments as OnBoardHomeCredentialsPageArguments;
    return const OnBoardHome();
  }

  Widget _onBoardCredentialsPageFunc(RouteSettings settings) {
    // OnBoardHomeCredentialsPageArguments height = settings.arguments as OnBoardHomeCredentialsPageArguments;
    return const OnBoardCredentials();
  }

  Widget _onBoardProfilePageFunc(RouteSettings settings) {
    // OnBoardHomeCredentialsPageArguments height = settings.arguments as OnBoardHomeCredentialsPageArguments;
    return const OnBoardProfile();
  }

  PageRouteBuilder<dynamic> _customPageRouteBuilder(
    RouteSettings settings,
    Widget Function(RouteSettings settings) pageFunc,
  ) {
    return PageRouteBuilder(
      pageBuilder: (_, ___, __) {
        return pageFunc(settings);
      },
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        Tween<Offset> tween = Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero);
        CurveTween cuveTween = CurveTween(curve: Curves.easeInOut);

        Animation<Offset> offsetAnimation = animation.drive(tween.chain(cuveTween));

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: RegulumThemes.ligthTheme,
      onGenerateRoute: (settings) {
        if (settings.name == OnBoardCredentials.route) {
          return _customPageRouteBuilder(settings, _onBoardCredentialsPageFunc);
        }
        if (settings.name == OnBoardProfile.route) {
          return _customPageRouteBuilder(settings, _onBoardProfilePageFunc);
        }

        return _customPageRouteBuilder(settings, _onBoardHomePageFunc);
      },
      initialRoute: _getInitialRoute(),
    );
  }
}

/// The main part of the app where the app is used
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: DefaultTextStyle(
        style: TextStyle(),
        child: Text("hi"),
      ),
    );
  }
}
