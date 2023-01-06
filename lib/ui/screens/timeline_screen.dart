import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/ui/style/app.dart';
import 'package:noteapp/ui/screens/note_reader.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'add_screen.dart';
import 'meeting_class.dart';
import '../custom_drawer.dart';
import '../style/app.dart';

String? _subjectText = '',
    _startTimeText = '',
    _locationText = '',
    _endTimeText = '',
    _dateText = '',
    _timeDetails = '';
Color? _headerColor, _viewHeaderColor, _calendarColor;

class Timeline extends StatefulWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  const Timeline({Key? key}) : super(key: key);
  // QuerySnapshot doc;
  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  get index => null;

  DocumentSnapshot<Object?>? get documentSnapshot => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: lightColor,
      appBar: theAppBar("Timeline"),
      drawer: const CustomDrawer(),
      floatingActionButton: theFAB(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AddNote()));
      }),
      body: StreamBuilder<QuerySnapshot>(
          stream: notes.snapshots(),
          builder: (context, snapshot) {
            return SfCalendar(
              view: CalendarView.day,
              // allowedViews: const [
              //   CalendarView.day,
              //   CalendarView.week,
              //   CalendarView.workWeek,
              //   CalendarView.month
              // ],
              // monthViewSettings: const MonthViewSettings(
              //     appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
              //     showAgenda: true),
              dataSource: MeetingDataSource(getAppointment()),
              appointmentTextStyle: const TextStyle(
                fontSize: 16,
                color: lightColor,
                fontFamily: 'Montserrat',
                letterSpacing: 2,
                fontWeight: FontWeight.w400,
              ),
              onTap: calendarTapped,
            );
          }),
    ));
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Appointment appointmentDetails = details.appointments![0];
      _subjectText = appointmentDetails.subject;
      _locationText = appointmentDetails.location;
      _dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.startTime)
          .toString();
      _startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.startTime).toString();
      _endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.endTime).toString();
      if (appointmentDetails.isAllDay) {
        _timeDetails = 'All day';
      } else {
        _timeDetails = '$_startTimeText - $_endTimeText';
      }
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Container(child: new Text('$_subjectText')),
              content: Container(
                height: 100,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '$_dateText',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(''),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '$_locationText',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(_timeDetails!,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18)),
                      ],
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close')),
                // FlatButton(
                //     onPressed: () {
                //       var snapshot;
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => NoteReader(doc)));
                //     },
                //     child: Text('Edit')),
              ],
            );
          });
    }
  }
}
