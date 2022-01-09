import 'package:flutter/material.dart';
import 'package:week10_shared_prefs_app/sign_in_screen.dart';
import 'package:week10_shared_prefs_app/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //в приложении два экрана
      routes: {
        //экран входа (показывается первым)
        '/': (context) => SignInScreen(),
        //экран регистрации
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}