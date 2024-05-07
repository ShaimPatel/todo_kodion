import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodion_projects/Screens/AuthLogin/widget/home.dart';
import '../../Apis/apis.dart';
import '../AuthLogin/auth_login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var isAnimated = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (APIs.auth.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AuthLogin()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: mq.height,
        width: mq.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.teal.shade300, Colors.green.shade300],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                tileMode: TileMode.clamp)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/chat.png",
              scale: 3,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "MADE IN INDIA WITH ❤️",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
