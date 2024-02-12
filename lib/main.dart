import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do/views/intrologo.dart';
import 'package:to_do/views/main_intro_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(000000)),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: const IntroLogo(),
      ),
    );
  }
}

