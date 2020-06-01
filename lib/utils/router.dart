import 'package:facebook_clone/constants/routes.dart';
import 'package:facebook_clone/ui/createmessage.dart';
import 'package:facebook_clone/ui/home.dart';
import 'package:facebook_clone/ui/signin.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginRoute:
      return _getPageRoute(
          routeName: settings.name, view: SignInSignUpScreen());
    case HomeRoute:
      return _getPageRoute(routeName: settings.name, view: HomeScreen());
      case NewMessageRoute:
      return _getPageRoute(routeName: settings.name, view: CreateMessage());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({String routeName, Widget view}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => view);
}
