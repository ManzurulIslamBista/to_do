import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TaskCatagoryButton extends StatefulWidget {
  String type = "";
  String iconAddress = "";
  String color = "";
  final Function(String) onPressed;
  TaskCatagoryButton({Key? key,required this.type,required this.iconAddress,required this.color,required this.onPressed}):super(key: key);

  @override
  State<TaskCatagoryButton> createState() => _TaskCatagoryButtonState();
}

class _TaskCatagoryButtonState extends State<TaskCatagoryButton> {

  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    String colorString = widget.color;
    Color color = Color(int.parse(colorString.substring(1, 7), radix: 16) + 0xFF000000);
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Color(0xDEFFFFFF)),
      ),
      onPressed: () {
        setState(() {
          _isPressed = !_isPressed;
        });
        widget.onPressed(widget.type);
      },
      child: SizedBox(
        height: 110,
        width: 110,
        child: Column(
          children: [Container(
            color: _isPressed ? Color(0xFF8687E7) : color,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  color: color,
                  child:ImageIcon(
                    AssetImage(
                        widget.iconAddress), // Replace 'path_to_your_image' with the actual path to your image asset
                    size: 24,
                    color: Colors.black54,
                  ),
                )

                // SvgPicture.asset(
                //   widget.iconAddress,
                //   semanticsLabel: 'uptodo SVG Image',
                //   height: 70,
                //   width: 70,
                //   fit: BoxFit.fitHeight,
                // ),
              ],
            ),
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.type.toString(),
                  style: TextStyle(color: Colors.white,fontSize: 12),
                ),
              ],
            ),
          ]
        ),
      ),
    );;
  }
}
