import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:to_do/providers/sql_helper.dart';
import 'package:provider/provider.dart';

class CreateNewCategory extends StatefulWidget {
  const CreateNewCategory({Key? key}) : super(key: key);

  @override
  _CreateNewCategoryState createState() => _CreateNewCategoryState();
}

class _CreateNewCategoryState extends State<CreateNewCategory> {
  TextEditingController _textController = TextEditingController();
  XFile? _iconFile;
  Color _selectedColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          'Create New Category',
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        backgroundColor: const Color(0xFF121212),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 7,
              child: Container(
                child: Column(
                  children: [
                    TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText: 'Category Name',
                        hintText: 'Category Name',
                        hintStyle: TextStyle(color: Color(0xFFAFAFAF)),
                        labelStyle: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _pickImage();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Color(0xDEAFAFAF), // Set the background color here
                          ),
                          child: Text(
                            'Choose Icon from librery',
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                          ),
                        ),
                      ],
                    ),
                    _iconFile != null
                        ? Image.file(
                      _iconFile!.path as File,
                      height: 200,
                    )
                        : Container(),

                    ColorPicker(
                      color: _selectedColor,
                      // Update the screenPickerColor using the callback.
                      onColorChanged: (Color color) =>
                          setState(() => _selectedColor = color),
                      width: 44,
                      height: 44,
                      borderRadius: 22,
                      enableShadesSelection: false,
                      heading: Text(
                        'Category Color ',
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                      subheading: Text(
                        'Select color shade',
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(flex: 1,
              child: Container(
                child: Column(
                  children: [
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Color(0xFF8687E7)),
                              )),
                          SizedBox(
                            width: 70,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.fromLTRB(40, 20, 40, 20)),
                              foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Color(0xFF8687E7)),
                              shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              String text = _textController.text;
                              String iconPath = _iconFile?.path ?? '';
                              context.read<SQLProvider>().insertCategory(
                                  name: text,
                                  iconPath: iconPath,
                                  color: _selectedColor);
                              _submitForm();
                              Navigator.of(context).pop();
                            },
                            child: Text('Create Category'),
                          ),
                        ],
                      ),
                    ])

                  ],
                ),
              ),
            )




          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _iconFile = pickedFile;
    });
  }

  void _submitForm() {
    String text = _textController.text;
    // Do something with the entered text, image, and color
    print('Text: $text');
    print('Image: ${_iconFile?.path}');
    print('Color: $_selectedColor');
    // You can add logic here to save the entry to a database or perform other operations.
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
