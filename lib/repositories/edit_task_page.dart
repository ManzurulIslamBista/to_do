import 'package:flutter/material.dart';
import 'package:to_do/providers/sql_helper.dart';
import 'package:provider/provider.dart';
import 'package:to_do/views/user_loged_page.dart';

import '../models/category_model.dart';

class EditTaskPage extends StatefulWidget {
  final int taskId;
  final String initialTitle;
  final String initialDescription;
  final DateTime initialDateTime;
  final String initialPriority;
  final int initialCategoryId;

  EditTaskPage({
    required this.taskId,
    required this.initialTitle,
    required this.initialDescription,
    required this.initialDateTime,
    required this.initialPriority,
    required this.initialCategoryId,
  });

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _selectedDateTime;
  late String _selectedPriority;
  late int _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController =
        TextEditingController(text: widget.initialDescription);
    _selectedDateTime = widget.initialDateTime;
    _selectedPriority = widget.initialPriority;
    _selectedCategoryId = widget.initialCategoryId;
  }

  Future<List<Category>> get categories async {
    return Provider.of<SQLProvider>(context, listen: false)
        .getAllCategoryRecords();
  }

  List<DropdownMenuItem<int>> _buildDropdownItems(List<Category> categories) {
    List<DropdownMenuItem<int>> items = [];
    for (var category in categories) {
      items.add(
        DropdownMenuItem(
          value: category.id,
          child: Text(category.name),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Center(child: Text('Edit Task', style: TextStyle(color: Colors.white))),
        backgroundColor: const Color(0xFF121212),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'Title', labelStyle: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'Description', labelStyle: TextStyle(color: Colors.white)),
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            ListTile(
              title: Text('Date and Time', style: TextStyle(color: Colors.white)),
              subtitle: Text(
                '${_selectedDateTime.year}-${_selectedDateTime.month}-${_selectedDateTime.day} ${_selectedDateTime.hour}:${_selectedDateTime.minute}',
              ),
              trailing: Icon(Icons.edit),
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDateTime,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
                  );
                  if (selectedTime != null) {
                    setState(() {
                      _selectedDateTime = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );
                    });
                  }
                }
              },
            ),
            SizedBox(height: 16.0),
            Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.black,
              ),
              child: FutureBuilder<List<Category>>(
                future: Provider.of<SQLProvider>(context).getAllCategoryRecords(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error loading categories', style: TextStyle(color: Colors.white));
                  } else {
                    List<Category> categories = snapshot.data ?? [];
                    return DropdownButtonFormField<int>(
                      dropdownColor: Colors.black54,
                      value: _selectedCategoryId,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(labelText: 'Category', labelStyle: TextStyle(color: Colors.white)),
                      items: _buildDropdownItems(categories),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedCategoryId = value;
                          });
                        }
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                await Provider.of<SQLProvider>(context, listen: false)
                    .updateTodoRecord(
                  id: widget.taskId,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  dateTime: _selectedDateTime,
                  priority: _selectedPriority,
                  categoryId: _selectedCategoryId,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserLoggedPage()
                  ),
                );
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
