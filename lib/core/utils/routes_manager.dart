import 'package:flutter/material.dart';
import 'package:todoo_app/presetation/screen/auth/login/login.dart';
import 'package:todoo_app/presetation/screen/auth/register/register.dart';
import 'package:todoo_app/presetation/screen/update/update_screen.dart';

import '../../presetation/screen/home/home_screen.dart';
import '../../presetation/screen/home/splash/splash_screen.dart';

class RoutesManager {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String register = '/register';
  static const String login = '/login';
  static const String updateScreen = '/update_Screen';

  static Route? router (RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case register:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case login:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );
      case updateScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const UpdateScreen(),
        );
    }}}