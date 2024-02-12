import 'package:chat_app/services/auth/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //logout method
  void logOut() {
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        actions: [
          //sign out
          IconButton(
            onPressed: logOut,
            icon: Icon(
              Icons.logout,
            ),
          )
        ],
      ),
    );
  }
}
