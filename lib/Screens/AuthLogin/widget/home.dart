import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kodion_projects/Apis/apis.dart';
import 'package:kodion_projects/Screens/AuthLogin/chat_user/chat_user.dart';
import 'package:kodion_projects/commonWidget/Text_Widget.dart';

class HomePage extends StatelessWidget {
  GoogleSignIn googleSignIn = GoogleSignIn();
  var credential;
  List<dynamic> list = [];

  HomePage({this.credential});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade300,
          leading: Container(
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2)),
            child: Icon(
              Icons.person,
              size: 30,
              color: Colors.white,
            ),
          ),
          title: Textwidget(
            title: "WE CHAT",
            fontsize: 17.8,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () async {
                await googleSignIn.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: StreamBuilder(
          stream: APIs.fireStore.collection("client").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return CircularProgressIndicator();
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasData) {
                  var data = snapshot.data.docs;
                  list = data.map((e) {
                        print(e.data());
                        ClientData.fromJson(e.data());
                      }).toList() ??
                      [];
                }
                return list.isNotEmpty
                    ? ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) => Card(
                              elevation: 1,
                              color: Colors.white,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 23,
                                  backgroundImage:
                                      NetworkImage(list[index].image),
                                ),
                                title: Text(
                                  list[index].name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  list[index].message,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ))
                    : SizedBox();
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.teal.shade400,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
