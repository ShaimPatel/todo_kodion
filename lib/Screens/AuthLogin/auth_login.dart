import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../Apis/apis.dart';
import '../../commonWidget/Text_Widget.dart';
import 'widget/home.dart';

class AuthLogin extends StatefulWidget {
  AuthLogin({super.key});

  @override
  State<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  var isAnimated = false;
  var load = false;

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ["email"]);

  GoogleSignInAccount? _account;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(microseconds: 3), () {
      setState(() {});
      isAnimated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    ///manage pot-rate size
    // MediaQuery.of(context).orientation == Orientation.landscape
    var mq = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.teal.shade300,
          centerTitle: true,
          leading: SizedBox(),
          title: Textwidget(
            title: 'Login Screen',
            fontsize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedPositioned(
              duration: Duration(seconds: 1),
              top: isAnimated ? mq.height * .2 : mq.height * .05,
              right: mq.width * .16,
              left: mq.width * .16,
              curve: Curves.bounceInOut,
              child: AnimatedContainer(
                width: mq.width * 0.6,
                height: isAnimated ? mq.height * .35 : mq.height * .0,
                curve: Curves.fastEaseInToSlowEaseOut,
                duration: Duration(milliseconds: 510),
                child: Image.asset(
                  "assets/images/chat.png",
                ),
              ),
            ),
            Positioned(
              top: mq.height * .7,
              left: mq.width * .05,
              right: mq.width * .05,
              child: ElevatedButton(
                onPressed: () {
                  showProgressBar();
                  getmethod();
                },
                child: RichText(
                  text: TextSpan(children: [
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          Icons.g_mobiledata,
                          size: 50,
                          color: Colors.blue.shade700,
                        )),
                    TextSpan(
                        text: "Sign In With ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: "Google",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold))
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getmethod() async {
    try {
      setState(() {
        load = true;
      });
      final user = await googleSignIn.signIn();
      if (user == null) return;
      _account = user;
      final authentication = await _account!.authentication;
      var credential = await GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);
      await APIs.auth.signInWithCredential(credential);

      setState(() {
        load = false;
      });
      print(user);
      if (await APIs.userExist()) {
        print("User is Exist");
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(credential: user)))
            .then((value) => Navigator.pop(context));
      } else {
        print("User is not Exist");
        await APIs.createUser().then((value) => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(credential: user))));
      }
    } on Exception catch (e) {
      print("Google signing issue: $e");
      setState(() {
        load = false;
      });
    }
  }

  showProgressBar() {
    return showDialog(
        context: context,
        builder: (_) => Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )));
  }
}
