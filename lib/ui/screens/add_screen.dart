import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:noteapp/ui/style/app.dart';

import '../style/add_style.dart';
import '../style/type_style.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<StatefulWidget> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  DateTime _selectedDate = DateTime.now();
  late DateTime _startTime = DateTime.now();
  late DateTime _endTime = DateTime.now();
  String title = '';
  String type = '';
  String description = '';
  String location = '';
  int _selectedIndex = 0;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: _selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime(2025))
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 8),
        child: Scaffold(
            backgroundColor: lightColor,
            appBar: AppBar(
                toolbarHeight: 44,
                elevation: 0.0,
                backgroundColor: lightColor,
                leading: Builder(builder: (BuildContext context) {
                  return IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                      color: Colors.red,
                      iconSize: 32);
                }),
                actions: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(right: 16.0),
                      child: ButtonTheme(
                          height: 20,
                          minWidth: 20,
                          child: noteButton("Save", () {
                            if (title == '' && title.trim() == '') {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        title:
                                            const Text('Missing Information'),
                                        content: const Text(
                                            'Please enter Title of the Event'),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('OK'))
                                        ]);
                                  });
                            } else if (description == '' &&
                                description.trim() == '') {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        title:
                                            const Text('Missing Information'),
                                        content: const Text(
                                            'Please enter Detail of the Event'),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('OK'))
                                        ]);
                                  });
                            } else if (location == '' &&
                                location.trim() == '') {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        title:
                                            const Text('Missing Information'),
                                        content: const Text(
                                            'Please enter Location of the Event'),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('OK'))
                                        ]);
                                  });
                            } else {
                              notes.doc(title).set({
                                "note_title": title,
                                "note_type": type,
                                "note_date": _selectedDate,
                                "time_start": _startTime,
                                "time_end": _endTime,
                                "note_description": description,
                                "note_location": location,
                                "is_completed": false,
                                "is_deleted": false,
                              });
                              Navigator.pop(context);
                            }
                          })))
                ]),
            body: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 8),
                    child: Column(children: [
                      TextField(
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLines: null,
                          style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'Montserrat',
                              color: btnColor),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.blue,
                              hintText: "Event Title",
                              hintStyle: TextStyle(
                                  color: btnColor,
                                  fontSize: 30,
                                  fontFamily: 'Montserrat')),
                          onChanged: (text) {
                            title = text;
                          }),
                      StreamBuilder<QuerySnapshot>(
                          stream: types
                              .orderBy('created_time', descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null ||
                                snapshot.data!.docs.isEmpty) {
                              return addNewType(context);
                            }
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 42.0,
                                    width: MediaQuery.of(context).size.width -
                                        100.0,
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.docs.length,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(width: 8.0),
                                        itemBuilder: (context, index) {
                                          type = snapshot.data!.docs[_selectedIndex]
                                              ['type_name'];
                                          return Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                color: _selectedIndex == index
                                                    ? Color(snapshot
                                                            .data!.docs[index]
                                                        ['type_color'])
                                                    : Colors.white),
                                            child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _selectedIndex = index;
                                                    type = snapshot.data!.docs[_selectedIndex]
                                                    ['type_name'];
                                                  });

                                                },
                                                child: Text(
                                                    snapshot.data!.docs[index]
                                                        ['type_name'],
                                                    style: TextStyle(
                                                        color: _selectedIndex ==
                                                                index
                                                            ? lightColor
                                                            : mainColor,
                                                        fontSize:
                                                            _selectedIndex ==
                                                                    index
                                                                ? 24.0
                                                                : 22.0,
                                                        fontFamily:
                                                            "Montserrat"))),
                                          );
                                        })),
                                IconButton(
                                    onPressed: () {
                                      addType(context);
                                    },
                                    icon: Icon(Icons.add_circle,
                                        color: mainColor, size: 40.0))
                              ],
                            );
                          }),
                      const SizedBox(height: 16.0),
                      ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(246, 255, 255, 255)),
                              fixedSize: MaterialStateProperty.all<Size>(
                                  const Size(double.maxFinite, 45)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24))))),
                          onPressed: () {
                            _presentDatePicker();
                          },
                          icon: const Icon(Icons.edit_calendar,
                              size: 35, color: btnColor),
                          label: Text(DateFormat.yMMMMd('en_Us').format(_selectedDate),
                              style: const TextStyle(
                                  color: btnColor,
                                  fontSize: 25,
                                  fontFamily: "Montserrat"))),
                      const SizedBox(height: 25),
                      Container(
                          height: 220,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(children: [
                                  SizedBox(
                                      width: 100,
                                      height: 200,
                                      child: Column(children: [
                                        const Text("Start",
                                            style: TextStyle(
                                                color: btnColor,
                                                fontSize: 24,
                                                fontFamily: 'Montserrat')),
                                        Expanded(
                                            child: CupertinoTheme(
                                                data: const CupertinoThemeData(
                                                    textTheme: CupertinoTextThemeData(
                                                        dateTimePickerTextStyle:
                                                            TextStyle(
                                                                color: btnColor,
                                                                fontFamily:
                                                                    'Montserrat'))),
                                                child: CupertinoDatePicker(
                                                    use24hFormat: true,
                                                    mode:
                                                        CupertinoDatePickerMode
                                                            .time,
                                                    onDateTimeChanged: (value) {
                                                      _startTime = value;
                                                    },
                                                    initialDateTime:
                                                        _startTime)))
                                      ]))
                                ]),
                                Column(children: [
                                  SizedBox(
                                      width: 100,
                                      height: 200,
                                      child: Column(children: [
                                        const Text("End",
                                            style: TextStyle(
                                                color: btnColor,
                                                fontSize: 24,
                                                fontFamily: 'Montserrat')),
                                        Expanded(
                                            child: CupertinoTheme(
                                                data: const CupertinoThemeData(
                                                    textTheme: CupertinoTextThemeData(
                                                        dateTimePickerTextStyle:
                                                            TextStyle(
                                                                color: btnColor,
                                                                fontFamily:
                                                                    'Montserrat'))),
                                                child: CupertinoDatePicker(
                                                    use24hFormat: true,
                                                    mode:
                                                        CupertinoDatePickerMode
                                                            .time,
                                                    onDateTimeChanged: (value) {
                                                      _endTime = value;
                                                    },
                                                    initialDateTime: _endTime)))
                                      ]))
                                ])
                                // noteTimePicker("End", _endTime)
                              ])),
                      const SizedBox(height: 25),
                      TextField(
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'Montserrat',
                              color: btnColor),
                          decoration: const InputDecoration(
                              fillColor: Colors.blue,
                              prefixIcon: Icon(Icons.format_list_bulleted,
                                  color: btnColor),
                              hintText: "Description",
                              hintStyle: TextStyle(
                                  color: btnColor,
                                  fontSize: 20,
                                  fontFamily: 'Montserrat')),
                          onChanged: (text) {
                            description = text;
                          }),
                      const SizedBox(height: 20),
                      TextField(
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'Montserrat',
                              color: btnColor),
                          decoration: const InputDecoration(
                              fillColor: Colors.blue,
                              prefixIcon: Icon(Icons.format_list_bulleted,
                                  color: btnColor),
                              hintText: "Location",
                              hintStyle: TextStyle(
                                  color: btnColor,
                                  fontSize: 20,
                                  fontFamily: 'Montserrat')),
                          onChanged: (text) {
                            location = text;
                          }),
                      // noteInputText(
                      //     "Description",
                      //     const Icon(Icons.format_list_bulleted,
                      //         color: btnColor),
                      //     description),
                      // const SizedBox(height: 20),
                      // noteInputText(
                      //     "Location",
                      //     const Icon(Icons.edit_location_outlined,
                      //         color: btnColor),
                      //     location),
                      const SizedBox(height: 20)
                    ])))));
  }
}
