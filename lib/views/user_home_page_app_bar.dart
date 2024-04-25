import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserAppBar extends StatefulWidget implements PreferredSizeWidget {
  const UserAppBar({Key? key}) : super(key: key);

  @override
  State<UserAppBar> createState() => _UserAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _UserAppBarState extends State<UserAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: Text("Index",style: TextStyle(color: Colors.white),)),
      leading: ImageIcon(
        AssetImage(
            "assets/images/sort.png"),
        size: 24,
        color: Color(0xFFFFFFFF),
      ),
      backgroundColor: const Color(0xFF121212),
      actions: [
        IconButton(
          onPressed: () {
            // Handle the onTap event for the circular image
          },
          icon: ClipOval(
            child: Image(image: Image.asset('assets/images/img.png').image,),
          ),
        ),
      ],

    );
  }
}
