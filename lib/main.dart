import 'package:chat_app/services/auth/auth_gate.dart';
import 'package:chat_app/services/auth/auth_services.dart';
import 'package:chat_app/services/auth/login_or_register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBd8GOZCEio0qZ96TE7y3YHnCSYip2Mla4",
      appId: "1:627365063585:android:f6043459471ce0c7fef9e0",
      messagingSenderId: "627365063585",
      projectId: "messenger-6d509",
    ),
  );
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterChat',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 49, 28, 101),
        ),
      ),
      home: AuthGate(),
    );
  }
}
