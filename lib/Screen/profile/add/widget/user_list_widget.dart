// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomListTileWidget extends StatelessWidget {
  String? userName;
  String? userEmail;
  String? userNameFirstLetter;

  CustomListTileWidget(
      {super.key, this.userName, this.userEmail, this.userNameFirstLetter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(userNameFirstLetter!),
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
