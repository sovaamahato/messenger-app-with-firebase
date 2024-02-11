import 'package:chat_app/components/my_btn.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  final void Function()? onTap;

  SignupPage({super.key, required this.onTap});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPassController = TextEditingController();

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
            width: 180,
            child: Image.asset("assets/images/chat.png"),
          ),
          Text(
            "Create New Account!",
            style: TextStyle(color: Colors.white),
          ),

          //actual form for signup---------------

          Card(
            margin: const EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                //email
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email Address ",
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        !value.contains('@')) {
                      return "please enter valid email address";
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                ),
                //password
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
                //confirm password
                TextFormField(
                  controller: confirmPassController,
                  obscuringCharacter: "*",
                  decoration: const InputDecoration(
                    labelText: " consfirm Password",
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
                MyBtn(onpressed: () {}, text: "Sign Up"),
                TextButton(
                    onPressed: widget.onTap,
                    child: const Text("Already have an account? Login")),
              ])),
            )),
          )
        ]),
      )),
    );
  }
}
