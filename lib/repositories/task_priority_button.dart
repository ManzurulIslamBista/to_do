import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskPriorityButton extends StatefulWidget {
  final int val;
  final Function(int) onPressed;

  TaskPriorityButton({Key? key, required this.val, required this.onPressed})
      : super(key: key);

  @override
  State<TaskPriorityButton> createState() => _TaskPriorityButtonState();
}

class _TaskPriorityButtonState extends State<TaskPriorityButton> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Color(0xDEFFFFFF)),
      ),
      onPressed: () {
        setState(() {
          _isPressed = !_isPressed;
        });
        widget.onPressed(widget.val);
      },
      child: SizedBox(
        height: 60,
        width: 50,
        child: Container(
          color: _isPressed ? Color(0xFF8687E7) : Color(0xFF272727),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(
                AssetImage(
                    'assets/images/flag.png'), // Replace 'path_to_your_image' with the actual path to your image asset
                size: 22,
                color: Color(0xFFFFFFFF),
              ),
              SizedBox(height: 2,),
              Text(
                widget.val.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
