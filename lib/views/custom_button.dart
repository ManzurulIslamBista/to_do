import 'package:flutter/cupertino.dart';

class CustomButton extends StatefulWidget {
  String buttonText = "";
   CustomButton({Key? key,required this.buttonText}):super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color(0xFF8687E7),
          borderRadius: BorderRadius.circular(5),

        ),
        child:  Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(widget.buttonText,style: TextStyle(
            color: Color(0xDEFFFFFF),
            fontSize: 16,
            // fontWeight: FontWeight.bold,
          ),
            textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}
