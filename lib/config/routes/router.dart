
import 'package:calling_chat_app/config/routes/routes_path.dart';
import 'package:calling_chat_app/features/sign_in/ui/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    // this argument is used to pass data from one screen to another
    final arguments = settings.arguments;
    switch (settings.name) {
      case RoutePath.login:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );
    }
    return null;
  }
}
