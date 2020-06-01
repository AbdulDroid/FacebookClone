import 'package:facebook_clone/constants/colors.dart';
import 'package:facebook_clone/services/dialog_service.dart';
import 'package:facebook_clone/ui/startpage.dart';
import 'package:facebook_clone/utils/dialog_manager.dart';
import 'package:facebook_clone/utils/locator.dart';
import 'package:facebook_clone/utils/navigator.dart';
import 'package:facebook_clone/utils/router.dart';
import 'package:flutter/material.dart';

void main() {
  // Register all the models and services before the app starts
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Avenir',
        hintColor: strokeDarker,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigatorService>().navigationKey,
      home: StartScreen(),
      onGenerateRoute: generateRoute,
    );
  }
}