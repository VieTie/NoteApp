import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/ui/screens/timeline_screen.dart';
import 'package:noteapp/ui/style/app.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<String> title = [];
List<String> locations = [];
List<String> note_type = [];
List<Timestamp> startList = [];
List<int> colors = [];
List<Timestamp> endList = [];
List<DateTime> starttimeList = [];
List<DateTime> endtimeList = [];
List<Appointment> meetings1 = [];

List<Appointment> addData() {
  notes.snapshots().listen((event) {
    title.clear();
    starttimeList.clear();
    endtimeList.clear();
    colors.clear();
    locations.clear();
    note_type.clear();
    event.docs.forEach((element) {
      // types
      //     .where('type_name', isEqualTo: element.get("note_type"))
      //     .snapshots()
      //     .listen((value) {
      //   value.docs.forEach((element) {
      //     colors.add(element.get("type_color"));
      //   });
      // });
      note_type.add(element.get("note_type"));
      title.add(element.get("note_title"));
      locations.add(element.get("note_location"));
      startList.add(element.get("time_start"));
      endList.add(element.get("time_end"));
    });
  });

  for (var element in startList) {
    starttimeList.add(element.toDate());
  }

  for (var element in endList) {
    endtimeList.add(element.toDate());
  }

  for (int i = 0; i < note_type.length; i++) {
    types
        .where('type_name', isEqualTo: note_type[i])
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        colors.add(element.get("type_color"));
      });
    });
  }
  print("Length ${colors.length}");
  for (int i = 0; i < title.length; i++) {
    meetings1.add(Appointment(
        startTime: starttimeList[i],
        endTime: endtimeList[i],
        subject: title[i],
        color: Color(colors[i]),
        // color: Colors.blue,
        location: locations[i]));
  }

  print("length meeting: ${meetings1.length}");
  return meetings1;
}

List<Appointment> getAppointment() {
  //List<Meeting> meeting_;
  meetings1.clear();

  print("Clear: ${meetings1.length}");
  addData();
  print("loaded");
  List<Appointment> meetings = meetings1;
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
    // setTextStyle();
  }
}
