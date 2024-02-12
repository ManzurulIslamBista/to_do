import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do/views/main_intro_page.dart';

class IntroLogo extends StatefulWidget {
  const IntroLogo({Key? key}) : super(key: key);

  @override
  State<IntroLogo> createState() => _IntroLogoState();
}

class _IntroLogoState extends State<IntroLogo> {
  @override
  void initState() { // Corrected method name
    super.initState();
    _changeTheStateToMainIntro();
  }

  void _changeTheStateToMainIntro() {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainIntroPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/Group 151.svg',
              semanticsLabel: 'uptodo SVG Image',
              height: 150,
              width: 100,
            ),
            const SizedBox(height: 10), // Adding some space between SVG and text
            const Text(
              'UpTodo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
