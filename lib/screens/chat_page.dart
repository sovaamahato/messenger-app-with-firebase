import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverID;
  final String receiverUserName;
  const ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverID,
      required this.receiverUserName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void sendMessage() async {
    //only send messge when it is not khali
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);
    }
    //clear text controller message send garepxi
    _messageController.clear();
  }

  //----------------\
  bool isMe = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.receiverUserName,
      )),
      body: Column(
        children: [
          //message
          Expanded(
            child: _buildMessageList(),
          ),
          //user input
          //textfield to type message------------------
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 165, 91, 177),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 165, 91, 177),
                        ),
                      ),
                    ),
                  )),
                  IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(
                        Icons.send,
                        color: Colors.deepPurple,
                        size: 30,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  //bild message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverID, _firebaseAuth.currentUser!.uid),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Error${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        if (!snapshot.hasData) {
          return Text("No data");
        } else {}
        print("=============================");
        print(snapshot.data);
        print("Document Count: ${snapshot.data!.docs.length}");
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
        // Access the documents from the snapshot
        //   final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

        //   return ListView.builder(
        //     itemCount: documents.length,
        //     itemBuilder: (context, index) {
        //       final document = documents[index];
        //       return _buildMessageItem(document);
        //     },
        //   );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //align the messages to the right if the sender is current user, otherwise to the left
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

//to get the time
    DateTime myDateTime = DateTime.parse(data['timestamp'].toDate().toString());
    String formattedDateTime = DateFormat('h:mm a').format(myDateTime);
    //set isme variable for chatbubble borrradius
    isMe = (data['senderId'] == _firebaseAuth.currentUser!.uid) ? true : false;
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment:
                (data['senderId'] == _firebaseAuth.currentUser!.uid)
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            children: [
              // Text("Message")
              Text(
                formattedDateTime.toString(),
                style: TextStyle(color: Colors.black),
              ),
              ChatBubble(
                isMe: isMe,
                message: data['message'],
              )
            ]),
      ),
    );
  }
}
