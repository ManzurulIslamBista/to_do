import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: SvgPicture.asset(
              "assets/images/Checklist-rafiki 1.svg",
              semanticsLabel: 'uptodo SVG Image',
              height: MediaQuery.of(context).size.height / 2.3,
              width: 100,
              fit: BoxFit.fitHeight,
            ),

          ),
          SizedBox(height: 20,),
          Text("What do you want to do today?",style: TextStyle(color: Colors.white),),
          Text("Tap • to add pur tasks",style: TextStyle(color: Colors.white)),

        ],

      ),
    );
  }
}
