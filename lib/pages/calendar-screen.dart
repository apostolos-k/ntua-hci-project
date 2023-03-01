import 'package:flutter/material.dart';
import 'package:my_car_wallet/pages/addevent-screen.dart';
import 'package:my_car_wallet/pages/showevents.dart';
import 'package:my_car_wallet/utils.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:my_car_wallet/models/event.dart';

import '../db_handler.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  late CalendarFormat format = CalendarFormat.month;
  late DateTime _selectedDay = DateTime.now();
  late DateTime _focusedDay = DateTime.now();
  late Map<DateTime, List<EventModel>> _events;

  DBHelper? dbHelper;
  late Future<List<EventModel>> datalistEvent;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    _events = {};
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      reverse: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(_screenHeight * 0.02),
            child: Text('Choose a date and add your appointment!',
                style: SafeGoogleFont('Sen',
                    fontSize: 2.4 * _screenHeight * 0.01,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff000000))),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 0.5 * _screenHeight,
                    width: 0.85 * _screenWidth,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(255, 78, 114, 182),
                              Color.fromARGB(255, 189, 154, 196),
                            ])),
                    child: TableCalendar(
                      focusedDay: _focusedDay,
                      pageAnimationEnabled: true,
                      firstDay: DateTime(1990),
                      lastDay: DateTime(2050),
                      calendarFormat: format,
                      onFormatChanged: (CalendarFormat _format) {
                        setState(() {
                          format = _format;
                        });
                      },
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      daysOfWeekVisible: true,

                      selectedDayPredicate: (date) {
                        return isSameDay(date, _selectedDay);
                      },

                      onDaySelected:
                          (DateTime selectedDay, DateTime focusedDay) {
                        print(_events[selectedDay]);

                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },

                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },

                      //To style the Calendar
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,
                        isTodayHighlighted: true,
                        selectedDecoration: BoxDecoration(
                          color: Color.fromARGB(255, 189, 154, 196),
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        todayDecoration: BoxDecoration(
                          color: Color.fromARGB(255, 160, 96, 171),
                          shape: BoxShape.circle,
                        ),
                        defaultDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        weekendDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: true,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        formatButtonShowsNext: false,
                        formatButtonDecoration: BoxDecoration(
                          color: Color.fromARGB(255, 189, 154, 196),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        formatButtonTextStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                //
                SizedBox(
                  height: 0.01 * _screenHeight,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ShowEvent()));
                      },
                      child: Container(
                          width: 0.33 * _screenWidth,
                          height: 0.05 * _screenHeight,
                          child: Center(
                            child: Text("Reveal Events",
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont('Sen',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white)),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              shape: BoxShape.rectangle,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 78, 114, 182),
                                    Color.fromARGB(255, 189, 154, 196),
                                  ]))),
                    ),
                    SizedBox(
                      height: 0.02 * _screenHeight,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEvent(
                                firstDate: DateTime(1990),
                                lastDate: DateTime(2050),
                                selectedDate: _selectedDay,
                              ),
                            ));
                      },
                      child: Container(
                          width: 0.13 * _screenWidth,
                          height: 0.08 * _screenHeight,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 189, 154, 196),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                )
                              ],
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 160, 96, 171),
                                    Color.fromARGB(255, 189, 154, 196),
                                  ]))),
                    ),
                  ],
                )
              ]),
        ],
      ),
    ));
  }
}
