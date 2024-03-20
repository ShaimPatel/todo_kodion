import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kodion_projects/Common/global_data.dart';
import 'package:kodion_projects/Screen/home/home_page.dart';

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
      home: const HomePage(),
      navigatorKey: GlobalData.navigatorStateKey,
    );
  }
}
