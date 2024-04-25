import 'package:flutter/material.dart';
import 'package:to_do/models/category_model.dart';
import 'package:to_do/repositories/task_catagory_button.dart';
import 'package:to_do/repositories/task_priority_button.dart';
import 'package:to_do/views/calender_page.dart';
import 'package:to_do/views/createnewcategory.dart';
import 'package:to_do/views/home_page.dart';
import 'package:to_do/views/user_home_page_app_bar.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:provider/provider.dart';
import '../providers/sql_helper.dart';

class UserLoggedPage extends StatefulWidget {
  const UserLoggedPage({Key? key}) : super(key: key);

  @override
  State<UserLoggedPage> createState() => _UserLoggedPageState();
}

class _UserLoggedPageState extends State<UserLoggedPage> {
  int _selectedIndex = 0;
  int selectedPriority = 0;
  int selectedCategory = 0;
  DateTime _putDateTime = DateTime.now();
  // DateTime _putTime = DateTime.now();
  late TextEditingController _titleController = TextEditingController();
  late TextEditingController _descriptionController = TextEditingController();

  void saveTask() async {
    // print(" ${_putDateTime.year}/${_putDateTime.month}/${_putDateTime.day} // ${_putDateTime.hour}:${_putDateTime.minute}:${_putDateTime.second} // ${_titleController.text} // ${_titleController.text}");
    // await context
    //     .read<SQLProvider>().showAllTables();
    await context.read<SQLProvider>().insertTodoRecord(
        title: _titleController.text,
        description: _descriptionController.text,
        dateTime: _putDateTime,
        priority: selectedPriority.toString(),
        categoryId: selectedCategory);
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CalenderPage(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _putDateTime,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      confirmText: "Choose Time",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSwatch(
              accentColor: Colors.white,
              backgroundColor: Colors.white,
              cardColor: const Color(0xFF363636),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _putDateTime) {
      _putDateTime = picked;
      print("picked date ");
      print(picked);
      print(_putDateTime);
    }
    chooseTime(context);
  }

  void chooseDateTime(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actionsPadding: const EdgeInsets.all(15),
            contentPadding: EdgeInsets.zero,
            backgroundColor: const Color(0xFF363636),
            title: const Center(
                child: Text(
              "Choose Date",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
              ),
            )),
            content: SizedBox(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.calendar_month,
                      size: 50,
                      color: Color(0xFFFFFFFF),
                    ),
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: _putDateTime,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.fromSwatch(
                                accentColor: Colors.white,
                                backgroundColor: Colors.white,
                                cardColor: const Color(0xFF363636),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (newDate == null) {
                        return;
                      } else {
                        setState(() => _putDateTime = newDate);
                      }
                    },
                  ),
                  Text(
                    '${_putDateTime.year}/${_putDateTime.month}/${_putDateTime.day}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color(0xFFFFFFFF)),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Color(0xFF8687E7)),
                      )),
                  const SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.all(10)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(const Color(0xFF8687E7)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      chooseTime(context);
                    },
                    child: const Text('Choose Time'),
                  ),
                ],
              )
            ],
          );
        });
  }

  void chooseTime(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF363636),
            title: const Center(
                child: Text(
              "Choose Time",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
              ),
            )),
            content: Row(
              children: [
                TimePickerSpinner(
                    is24HourMode: false,
                    normalTextStyle:
                        const TextStyle(fontSize: 24, color: Color(0x1AFFFFFF)),
                    highlightedTextStyle:
                        const TextStyle(fontSize: 24, color: Color(0xFFFFFFFF)),
                    spacing: 50,
                    itemHeight: 50,
                    isForce2Digits: true,
                    onTimeChange: (time) {
                      setState(() {
                        // _putTime = time;
                        _putDateTime = time;
                      });
                    })
              ],
            ),
            actions: [
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Color(0xFF8687E7)),
                      )),
                  const SizedBox(
                    width: 40,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.fromLTRB(40, 10, 40, 10)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(const Color(0xFF8687E7)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      showAddTask(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              )
            ],
          );
        });
  }

  void addTaskPriority(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: const Color(0xFF363636),
            insetPadding: const EdgeInsets.fromLTRB(0, 170, 0, 150),
            child: AlertDialog(
              backgroundColor: const Color(0xFF363636),
              contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              actionsPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              title: const Center(
                  child: Text(
                "Task Priority",
                style: TextStyle(color: Color(0xFFFFFFFF)),
              )),
              content: Column(
                children: [
                  Row(
                    children: [
                      TaskPriorityButton(
                        val: 1,
                        onPressed: (priority) {
                          selectedPriority = priority; //
                        },
                      ),
                      TaskPriorityButton(
                        val: 2,
                        onPressed: (priority) {
                          selectedPriority = priority; //
                        },
                      ),
                      TaskPriorityButton(
                        val: 3,
                        onPressed: (priority) {
                          selectedPriority = priority; //
                        },
                      ),
                      TaskPriorityButton(
                        val: 4,
                        onPressed: (priority) {
                          selectedPriority = priority; //
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TaskPriorityButton(
                        val: 5,
                        onPressed: (priority) {
                          selectedPriority = priority; //
                        },
                      ),
                      TaskPriorityButton(
                        val: 6,
                        onPressed: (priority) {
                          selectedPriority = priority; //
                        },
                      ),
                      TaskPriorityButton(
                        val: 7,
                        onPressed: (priority) {
                          selectedPriority = priority; //
                        },
                      ),
                      TaskPriorityButton(
                        val: 8,
                        onPressed: (priority) {
                          selectedPriority = priority; //
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TaskPriorityButton(
                        val: 9,
                        onPressed: (priority) {
                          selectedPriority = priority;
                        },
                      ),
                      TaskPriorityButton(
                        val: 10,
                        onPressed: (priority) {
                          selectedPriority = priority;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Color(0xFF8687E7)),
                          )),
                      const SizedBox(
                        width: 100,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.fromLTRB(40, 20, 40, 20)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF8687E7)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          print(selectedPriority);
                          showAddTask(context);
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void addTagCategory(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF363636),
          insetPadding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
          child: FutureBuilder<List<Category>>(
            future: context.read<SQLProvider>().getAllCategoryRecords(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error fetching categories'));
              } else {
                List<Category>? categories = snapshot.data;
                return AlertDialog(
                  backgroundColor: const Color(0xFF363636),
                  contentPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  actionsPadding: EdgeInsets.zero,
                  titlePadding: EdgeInsets.zero,
                  title: const Text(
                    "Choose Category",
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                  content: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Column(
                      children: [
                        GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: categories?.map((category) {
                            return SizedBox(
                              height: 120, // Adjust height as needed
                              width: 120, // Adjust width as needed
                              child: TaskCatagoryButton(
                                type: category.name,
                                iconAddress: category.iconPath ?? "",
                                color: category.color,
                                onPressed: (type) {
                                  selectedCategory = category.id ?? 0;
                                  if (type == "Create New") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const CreateNewCategory()),
                                    );
                                  }
                                },
                              ),
                            );
                          }).toList() ?? [],
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.fromLTRB(80, 10, 90, 15),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF8687E7)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            print(selectedCategory);
                            Navigator.of(context).pop();
                            showAddTask(context);
                          },
                          child: const Text('Add Category',style: TextStyle(fontSize: 16),),
                        ),
                      ],
                    ),

                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  void showAddTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF363636),
          insetPadding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height/5, 0, 0),
          child: AlertDialog(
            backgroundColor: const Color(0xFF363636),
            contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            actionsPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            title: const Text(
              "Add Task",
              style: TextStyle(color: Color(0xFFFFFFFF)),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    autofocus: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(color: Color(0xFFAFAFAF))),
                  ),
                  TextField(
                    controller: _descriptionController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: "Description",
                        hintStyle: TextStyle(color: Color(0xFFAFAFAF))),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        // chooseDateTime(context);
                        _selectDate(context);
                      },
                      icon: const ImageIcon(
                        AssetImage(
                            'assets/images/timer.png'), // Replace 'path_to_your_image' with the actual path to your image asset
                        size: 24,
                        color: Color(0xFFFFFFFF),
                      )),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: IconButton(
                      onPressed: () {
                        addTagCategory(context);
                      },
                      icon: const ImageIcon(
                        AssetImage(
                            'assets/images/tag.png'), // Replace 'path_to_your_image' with the actual path to your image asset
                        size: 24,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        addTaskPriority(context);
                      },
                      icon: const ImageIcon(
                        AssetImage(
                            'assets/images/flag.png'), // Replace 'path_to_your_image' with the actual path to your image asset
                        size: 24,
                        color: Color(0xFFFFFFFF),
                      )),
                  const SizedBox(
                    width: 50,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        saveTask();
                        // context.read<SQLProvider>().showAllTables();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const UserLoggedPage(),
                          ),
                        );
                      },
                      icon: const ImageIcon(
                        AssetImage(
                            'assets/images/send.png'), // Replace 'path_to_your_image' with the actual path to your image asset
                        size: 24,
                        color: Color(0xFF8687E7),
                      )),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const UserAppBar(),
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTask(context);
        },
        shape: const CircleBorder(),
        backgroundColor: const Color(0xff8687e7),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Stack(
        children: [
          BottomAppBar(
            height: 90,
            color: const Color(0xFF363636),
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Column(
                    children: [
                      Icon(Icons.home),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Index",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFAFFFFFF)),
                      )
                    ],
                  ),
                  onPressed: () => _onItemTapped(0),
                  color: _selectedIndex == 0 ? const Color(0xFFFFFFFF) : const Color(0x99FFFFFF),
                ),
                IconButton(
                  icon: const Column(
                    children: [
                      Icon(Icons.calendar_month),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Calender",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFAFFFFFF)),
                      )
                    ],
                  ),
                  onPressed: () => _onItemTapped(1),
                  color: _selectedIndex == 1 ? Colors.amber : const Color(0xFAFFFFFF),
                ),
                const SizedBox(width: 48.0), // SizedBox to leave space for the FAB
                IconButton(
                  icon: const Column(
                    children: [
                      Icon(Icons.access_time),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Focus",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFAFFFFFF)),
                      )
                    ],
                  ),
                  onPressed: () => _onItemTapped(2),
                  color: _selectedIndex == 2 ? Colors.amber : const Color(0xFAFFFFFF),
                ),
                IconButton(
                  icon: const Column(
                    children: [
                      Icon(Icons.account_circle_outlined),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Profile",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFAFFFFFF)),
                      )
                    ],
                  ),
                  onPressed: () => _onItemTapped(3),
                  color: _selectedIndex == 3 ? Colors.amber : const Color(0xFAFFFFFF),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
