import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do/providers/sql_helper.dart';
import 'package:provider/provider.dart';
import 'package:to_do/repositories/edit_task_page.dart';
import 'package:to_do/views/user_loged_page.dart';

class TaskDetails extends StatefulWidget {
  final Map<String, dynamic> record;
  String categoryName = "";
  String categoryIconPath = "";
  TaskDetails(
      {Key? key,
      required this.record,
      required this.categoryName,
      required this.categoryIconPath})
      : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    print(widget.categoryName);
    // String date = '${dateTime.year}-${dateTime.month}-${dateTime.day}';
    // String time = '${dateTime.hour}:${dateTime.minute}:${dateTime.second}';

    String _getFormattedDate(String value) {
      DateTime dateTime = DateTime.parse(value);
      DateTime now = DateTime.now();
      DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
      String formattedDate = '';

      if (dateTime.year == now.year &&
          dateTime.month == now.month &&
          dateTime.day == now.day) {
        formattedDate =
        'Today At ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
      } else if (dateTime.year == yesterday.year &&
          dateTime.month == yesterday.month &&
          dateTime.day == yesterday.day) {
        formattedDate =
        'Yesterday At ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
      } else {
        formattedDate =
        '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime
            .hour}:${dateTime.minute}:${dateTime.second}';
      }

      return formattedDate;
    }

    String dateTime = _getFormattedDate(widget.record['date_time']);
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            context.read<SQLProvider>().deleteTodoRecord(widget.record['id']);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserLoggedPage()
              ),
            );
            }, icon: Icon(Icons.delete_forever_outlined, size: 30, color: Colors.red,)),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskPage(
                    taskId: widget.record['id'],
                    initialTitle: widget.record['title'],
                    initialDescription: widget.record['description'],
                    initialDateTime: DateTime.parse(widget.record['date_time']),
                    initialPriority: widget.record['priority'],
                    initialCategoryId: widget.record['categoryId'],
                  ),
                ),
              );
            },
            icon: Icon(Icons.edit, size: 30, color: Colors.white,),
          ),
        ],
        backgroundColor: Color(0xFF121212),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: ImageIcon(
            AssetImage("assets/images/Close.png"),
            size: 20,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    12),
                                // Adjust the radius according to your needs
                                border: Border.all(
                                  color: Colors
                                      .white,
                                  // Set the color of the border to white
                                  width: 2, // Set the width of the border
                                ),
                              ),
                              child: ImageIcon(
                                AssetImage('assets/images/Ellipse 15.png'),
                                size: 16,
                                color: Color(0xFF363636),
                              ),
                            ),
                            SizedBox(height: 32,)
                          ],
                        ),
                        SizedBox(width: 20,),
                        Expanded(flex: 4,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(widget.record['title'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xDEFFFFFF))),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Text(widget.record['description'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFAFAFAF))),
                                ],
                              )
                            ],
                          ),
                        ),
                        // Expanded(flex: 1,
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: [
                        //       ImageIcon(
                        //         AssetImage('assets/images/edit-2.png'),
                        //         size: 30,
                        //         color: Color(0xFFFFFFFF),
                        //       ),
                        //       SizedBox(height: 25,)
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              _buildDetailRow(
                  'assets/images/timer.png', '  Task Time:', dateTime, ''),
              // _buildDetailRow('assets/images/timer.png','Time:', time),
              _buildDetailRow('assets/images/tag.png', '  Task Category:',
                  '${widget.categoryName}', '${widget.categoryIconPath}'),
              _buildDetailRow('assets/images/flag.png', '  Task Priority:',
                  '${widget.record['priority']}', ''),
              // Add more details as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String iconAdd, String label, String value,
      String iconPath) {
    if (iconPath != "") {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            ImageIcon(
              AssetImage(iconAdd),
              size: 24,
              color: Color(0xFFFFFFFF),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
            ),
            SizedBox(width: 100),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Color(0x36FFFFFF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      ImageIcon(
                        AssetImage(iconPath),
                        size: 24,
                        color: Color(0xFFFFFFFF),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        value,
                        style: TextStyle(
                            fontSize: 16, color: Color(0xFFFFFFFF)),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            ImageIcon(
              AssetImage(iconAdd),
              size: 24,
              color: Color(0xFFFFFFFF),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
            ),
            SizedBox(width: 100),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Color(0x36FFFFFF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Text(
                        value,
                        style: TextStyle(
                            fontSize: 16, color: Color(0xFFFFFFFF)),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
