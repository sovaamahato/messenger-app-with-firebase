import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//import 'package:intl/intl.dart' as intl;

class ChatBubble extends StatelessWidget {
  final String message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 176, 96, 190),
        //color: data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          //bottomRight: data['uid'] == currentUser!.uid
          //       ? const Radius.circular(0)
          //       : const Radius.circular(20),
          //   bottomLeft: data['uid'] == currentUser!.uid
          //       ? const Radius.circular(20)
          //       : const Radius.circular(0),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(message),
      ]),
    );
    ;
  }
}

// Widget senderBubble(DocumentSnapshot data) {
//   // var t =
//   //     data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
//   // var time = intl.DateFormat("h:mma").format(t);

  
// }
