import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/Common/global_data.dart';
import 'package:kodion_projects/Screen/Home/home_page.dart';
import 'package:kodion_projects/Screen/google%20map/google_map_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GoogleMapPage(),
      navigatorKey: GlobalData.navigatorStateKey,
    );
  }
}
