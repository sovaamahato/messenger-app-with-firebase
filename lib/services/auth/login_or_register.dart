import 'package:chat_app/screens/login_page.dart';
import 'package:chat_app/screens/signup_page.dart';
import 'package:flutter/material.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({super.key});

  @override
  State<LoginOrSignup> createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
//initially login page
  bool showLoginPage = true;

  //toggle between login and signup page
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return AuthScreen(onTap: togglePage);
    } else {
      return SignupPage(onTap: togglePage);
    }
  }
}
