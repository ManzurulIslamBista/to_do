
import 'package:flutter/material.dart';
import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';
import 'package:to_do/views/home_page.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  final _calendarControllerToday = AdvancedCalendarController.today();
  final _calendarControllerCustom =
  AdvancedCalendarController(DateTime(2022, 10, 23));
  final events = <DateTime>[
    DateTime.now(),
    DateTime(2022, 10, 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AdvancedCalendar(
                    headerStyle: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFFFFFFF),

                    ),
                    todayStyle: TextStyle(
                    fontSize: 20,
                      color: Color(0xFFFFFFFF),

                    ),
                    controller: _calendarControllerToday,
                    events: events,
                    weekLineHeight: 60.0,
                    startWeekDay: 1,
                    innerDot: true,
                    keepLineSize: true,
                    calendarTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      height: 1.3125,
                      letterSpacing: 0,
                      // backgroundColor: Color(0xFF363636),
                      color: Color(0xFFFFFFFF),
                    ),
                  ),

                  Column(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          color: Colors.amber,
                        ),
                        HomePage()
                      ],
                    )
                ],
              )
            ),
          ),
        );
  }
}