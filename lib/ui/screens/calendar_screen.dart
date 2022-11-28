import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../custom_drawer.dart';
import '../style/app.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      appBar: theAppBar("Calendar"),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2022),
          lastDay: DateTime(2025),
          //Format Calendar
          calendarFormat: _format,
          daysOfWeekHeight: 20.0,
          rowHeight: 36.0,
          startingDayOfWeek: StartingDayOfWeek.monday,
          weekendDays: const [DateTime.sunday],
          //HeaderStyle
          headerStyle: HeaderStyle(
              leftChevronIcon: Icon(Icons.chevron_left,
                  color: mainColor, size: 24.0),
              rightChevronIcon: Icon(Icons.chevron_right,
                  color: mainColor, size: 24.0),
              //formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle:
              TextStyle(color: mainColor, fontSize: 20.0),
              decoration: const BoxDecoration(
                  color: lightColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              formatButtonTextStyle: TextStyle(color: mainColor),
              formatButtonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white)),
          daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: const TextStyle(color: Colors.red),
              weekdayStyle: TextStyle(color: mainColor)),
          calendarStyle: CalendarStyle(
              weekendTextStyle: const TextStyle(color: Colors.red),
              isTodayHighlighted: true,
              todayDecoration: BoxDecoration(
                  color: mainColor.withOpacity(0.5),
                  shape: BoxShape.circle),
              selectedDecoration: BoxDecoration(
                  color: mainColor, shape: BoxShape.circle),
              selectedTextStyle: const TextStyle(color: lightColor)),
          //Change Format
          onFormatChanged: (CalendarFormat format) {
            setState(() {
              _format = format;
            });
          },
          // Change Day
          onDaySelected: (DateTime selectDay, DateTime focusDay) {
            setState(() {
              _selectedDay = selectDay;
              _focusedDay = focusDay;
            });
          },
          selectedDayPredicate: (DateTime date) {
            return isSameDay(_selectedDay, date);
          })
        ],
      ),
    );
  }
}
