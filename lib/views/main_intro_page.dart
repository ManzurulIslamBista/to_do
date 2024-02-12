import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainIntroPage extends StatefulWidget {
  const MainIntroPage({super.key});

  @override
  State<MainIntroPage> createState() => _MainIntroPageState();
}

class _MainIntroPageState extends State<MainIntroPage> {
  Widget _buildImage(String imagePath) {
    return Image.asset(
      imagePath,
      height: 300,
      width: 300,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // First Image
                    _buildImage('assets/images/Frame 161.png'),

                    // Second Image
                    _buildImage('assets/images/Frame 162.png'),

                    // Third Image
                    _buildImage('assets/images/Group 182.png'),
                  ],
                ),
              ),
            )
          ],
        ),
        Container(
          width:350 ,
          child: const Column(
            children: [
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Manage your tasks",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Expanded(
                  child: Center(
                    child: Text("You can easily all Of daily tasks in DoMe for free",style:TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),textAlign: TextAlign.center,),
                  ),
                )],
              )
            ],
          ),
        )

      ],
    );
  }
}
