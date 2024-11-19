import 'package:flutter/material.dart';

import 'cofig/theme/app_theme.dart';
import 'core/utils/routes_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesManager.router,
      initialRoute: RoutesManager.splash,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,

    );
  }
}