import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/setting_provider.dart';
import 'package:weather_app/router/route_config.dart';
import 'package:weather_app/router/route_name.dart';

void main() {
  runApp(const MyApp());
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingProvider())
      ],
      builder: (context, child) => MaterialApp(
        scaffoldMessengerKey: GlobalKey<ScaffoldMessengerState>(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: RouteConfig.I.onGenerateRoute,
        initialRoute: RouteName.init,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
