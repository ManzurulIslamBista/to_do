import 'package:flutter/material.dart';

class PageIndexTracker extends StatefulWidget {
  bool currentIndex = true;
  PageIndexTracker({Key? key, required this.currentIndex}):super(key: key);

  @override
  State<PageIndexTracker> createState() => _PageIndexTrackerState();
}

class _PageIndexTrackerState extends State<PageIndexTracker> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Container(
          height: 5,
          width: 40,

          decoration: BoxDecoration(
              color: widget.currentIndex == true ? Color(0xDEFFFFFF) :  Colors.grey,
              borderRadius: BorderRadius.circular(10)
          ),
        ),
        const SizedBox(width: 5,),
      ],
    );
  }
}
