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
      leading: PopupMenuButton<String>(
        icon: Icon(Icons.abc_rounded),
                 iconColor: Colors.white,
                onSelected: (value) {
                  // Handle menu item selection
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'menu_item_1',
                    child: Text('Menu Item 1'),
                  ),
                  PopupMenuItem<String>(
                    value: 'menu_item_2',
                    child: Text('Menu Item 2'),
                  ),
                  PopupMenuItem<String>(
                    value: 'menu_item_3',
                    child: Text('Menu Item 3'),
                  ),
                ],
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
