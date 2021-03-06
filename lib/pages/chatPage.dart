import 'package:chat_app/helpers/firebase_helper.dart';
import 'package:chat_app/pages/chatMessage.dart';
import 'package:chat_app/pages/textComposer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  FirebaseHelper helper = FirebaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                  stream: helper.snapshots(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        List<DocumentSnapshot> documents =
                            snapshot.data.documents.reversed.toList();
                        return ListView.builder(
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              documents[index].data();
                              documents[index].data()["uid"] ==
                                  helper.currentUser?.uid;
                            });
                    }
                  })),
          TextComposer()
        ],
      ),
    );
  }
}
