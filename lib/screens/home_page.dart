import 'package:chat_app/services/auth/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
          backgroundColor: const Color.fromARGB(255, 107, 35, 119),
          title: const Text(
            'Messenger ',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            //sign out
            IconButton(
              onPressed: logOut,
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Container(
            color: Color.fromARGB(255, 231, 208, 235),
            child: _buildUserList()));
  }

  //build a list of users except for the current legged in user
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(child: const Text('error'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(child: const Text("Loading..."));
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  //build individual user list items

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

//display all users except current user
    if (_auth.currentUser!.email != data['email']) {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Card(
          child: ListTile(
              title: Text(
                data['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data['email']),
              onTap: () {
                //pass th clicked user's UID to the chat page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      receiverUserName: data['name'],
                      receiverUserEmail: data['email'],
                      receiverID: data['uid'],
                    ),
                  ),
                );
              }),
        ),
      );
    } else {
      return Container();
    }
  }
}
