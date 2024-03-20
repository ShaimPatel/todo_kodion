// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class UserListCardWidget extends StatelessWidget {
  String? userName;
  String? userEmail;
  String? userNameFirstLetter;

  UserListCardWidget(
      {super.key, this.userName, this.userEmail, this.userNameFirstLetter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        height: 70,
        width: double.maxFinite,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            // border: Border.all(
            //   color: Colors.black,
            // ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 2,
                color: Colors.black12,
                offset: Offset(2, 2),
              ),
              BoxShadow(
                blurRadius: 2,
                color: Colors.black12,
                offset: Offset(-1, -1),
              ),
            ]),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.black,
            child: Text(
              userNameFirstLetter!,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(
            userName!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            userEmail!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
