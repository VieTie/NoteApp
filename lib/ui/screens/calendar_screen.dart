import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../custom_drawer.dart';
import '../style/app.dart';
import 'add_screen.dart';
import 'meeting_class.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      appBar: theAppBar("Calendar"),
      drawer: const CustomDrawer(),
      floatingActionButton: theFAB(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AddNote()));
      }),
      body: StreamBuilder<QuerySnapshot>(
          stream: notes.snapshots(),
          builder: (context, snapshot) {
            return SfCalendar(
              view: CalendarView.month,
              // allowedViews: const [
              //   CalendarView.day,
              //   CalendarView.week,
              //   CalendarView.workWeek,
              //   CalendarView.month
              // ],
              monthViewSettings: const MonthViewSettings(
                  appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                  showAgenda: true),
              dataSource: MeetingDataSource(getAppointment()),
              appointmentTextStyle: const TextStyle(
                fontSize: 16,
                color: lightColor,
                fontFamily: 'Montserrat',
                letterSpacing: 2,
                fontWeight: FontWeight.w400,
              ),
              //onTap: calendarTapped,
            );
          }),
    );
  }
}
