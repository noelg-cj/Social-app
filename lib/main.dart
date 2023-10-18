import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_app/auth/auth.dart';
import 'package:social_app/auth/login_or_register.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/pages/home_page.dart';
import 'package:social_app/pages/profile_page.dart';
import 'package:social_app/pages/users_page.dart';
import 'package:social_app/theme/dark_mode.dart';
import 'package:social_app/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_register_page' : (context) => const LoginOrRegister(),
        '/home_page' :(context) => const HomePage(),
        '/profile_page' :(context) => ProfilePage(),
        '/users_page' :(context) => const UsersPage(),
      }
    );
  }
}
