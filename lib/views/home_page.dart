import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../providers/sql_helper.dart';
import 'package:provider/provider.dart';

import '../repositories/task_details_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: context.read<SQLProvider>().getAllTodoRecords(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> data) {
        if (data.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (data.data != null && data.data!.isNotEmpty) {
            print(data.data);
            return ListView.builder(
              itemCount: data.data!.length,
              itemBuilder: (context, index) {
                final record = data.data![index];
                String _getFormattedDate(String value) {
                  DateTime dateTime = DateTime.parse(value);
                  DateTime now = DateTime.now();
                  DateTime yesterday =
                      DateTime(now.year, now.month, now.day - 1);
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
                        '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
                  }

                  return formattedDate;
                }

                String dateTime = _getFormattedDate(record['date_time']);

                return FutureBuilder<Map<String, dynamic>>(
                  future: context
                      .read<SQLProvider>()
                      .getCategoryDetailsRecords(record['categoryId']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError || snapshot.data == null) {
                      return const Text('Error fetching category details');
                    } else {
                      final categoryDetails = snapshot.data!;
                      String colorString = categoryDetails['color'];
                      Color color = Color(
                          int.parse(colorString.substring(1, 7), radix: 16) +
                              0xFF000000);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetails(
                                record: record,
                                categoryName: categoryDetails['name'],
                                categoryIconPath: categoryDetails['iconPath'],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      12),
                                  border: Border.all(
                                    color: Colors
                                        .white,
                                    width: 2,
                                  ),
                                ),
                                child: const ImageIcon(
                                  AssetImage('assets/images/Ellipse 15.png'),
                                  size: 15,
                                  color: Color(0xFF363636),
                                ),
                              ),
                              tileColor: const Color(0xFF363636),
                              title: Text(
                                record['title'],
                                style: const TextStyle(
                                    color: Color(0xDEFFFFFF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              subtitle: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "$dateTime",
                                          style: const TextStyle(
                                              color: Color(0xDEAFAFAF),
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: color,
                                              ),
                                              child: Center(
                                                  child: Row(
                                                children: [
                                                  const SizedBox(width: 5,),
                                                  ImageIcon(
                                                    AssetImage(
                                                        categoryDetails['iconPath']),
                                                    size: 24,
                                                    color: const Color(0xFFFFFFFF),
                                                  ),
                                                  const SizedBox(width: 10,),
                                                  Text(
                                                    categoryDetails['name'],
                                                    style: const TextStyle(
                                                        color: Color(0xFFFFFFFF)),
                                                  ),
                                                ],
                                              )),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: 50,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.indigoAccent,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const ImageIcon(
                                                    AssetImage(
                                                        "assets/images/flag.png"),
                                                    size: 24,
                                                    color: Color(0xFFFFFFFF),
                                                  ),
                                                  Text(
                                                    "${record['priority']}",
                                                    style: const TextStyle(
                                                        color: Color(0xFFFFFFFF)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // SizedBox(width: 5,),
                                            // GestureDetector(
                                            //   onTap: () async {
                                            //     await context.read<SQLProvider>().deleteTodoRecord(record['id']);
                                            //   },
                                            //   child: Container(
                                            //     child: Icon(Icons.delete_forever_outlined, size: 30, color: Colors.red,),
                                            //   ),
                                            // )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            );
          } else {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height > 500
                      ? MediaQuery.of(context).size.height / 8
                      : 0,
                ),
                Center(
                  child: SvgPicture.asset(
                    "assets/images/Checklist-rafiki 1.svg",
                    semanticsLabel: 'uptodo SVG Image',
                    height: MediaQuery.of(context).size.height / 2.8,
                    width: 100,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "What do you want to do today?",
                  style: TextStyle(color: Colors.white),
                ),
                const Text("Tap • to add pur tasks",
                    style: TextStyle(color: Colors.white)),
              ],
            );
          }
        }
      },
    );
  }
}
