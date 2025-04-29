import 'package:chat_app/components/my_btn.dart';
import 'package:chat_app/services/auth/auth_services.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  final void Function()? onTap;
  const AuthScreen({super.key, required this.onTap});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
//text controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //login user
  void LogIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
          child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: const EdgeInsets.only(
              top: 30,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            width: 160,
            child: Image.asset("assets/images/chat.png"),
          ),
          const Text(
            "Welcome Back!",
            style: TextStyle(color: Colors.white),
          ),

          //actual form for signup---------------

          Card(
            margin: const EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email Address ",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                ),
                TextFormField(
                  controller: passwordController,
                  obscuringCharacter: "*",
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().length < 6) {
                      return "password must be 6 character long";
                    }
                    return null;
                  },
                ),
                MyBtn(onpressed: LogIn, text: "Login"),
                TextButton(
                    onPressed: widget.onTap,
                    child: const Text("Do not have account? Sign Up")),
              ]),
            )),
          )
        ]),
      )),
    );
  }
}
