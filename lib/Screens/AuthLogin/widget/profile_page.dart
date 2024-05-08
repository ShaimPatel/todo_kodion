import 'package:flutter/material.dart';
import 'package:kodion_projects/Screens/AuthLogin/chat_user/chat_user.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage(this.list, {super.key});

  ClientData list;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = list.name.toString();
    aboutController.text = list.message.toString();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    child: Image.network(
                      list.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.edit),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              list.email.toString(),
              style: TextStyle(fontSize: 15.0),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: aboutController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.edit),
              label: Text('UPDATE'),
            )
          ],
        ),
      ),
    );
  }
}
