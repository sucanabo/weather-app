import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/ui/setting_screen.dart';

import '../ui/home_screen.dart';
import 'route_name.dart';


class RouteConfig {
  static RouteConfig? _i;

  RouteConfig._();

  static RouteConfig get I {
    _i ??= RouteConfig._();
    return _i!;
  }

  Route onGenerateRoute(RouteSettings settings) {
    debugPrint(
        "===Navigate to [${settings.name}]\n===Args: ${settings.arguments}");
    switch (settings.name) {
      case RouteName.init:
      case RouteName.home:
        return _buildRoute(
          settings,
          const HomeScreen(),
        );
      case RouteName.setting:
        return _buildRoute(
          settings,
          const SettingScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Coming soon'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      );
    });
  }

  static Route _buildRoute(RouteSettings settings, Widget builder) {
    if (Platform.isIOS) {
      return CupertinoPageRoute(
        settings: settings,
        builder: (BuildContext context) => builder,
      );
    }
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
