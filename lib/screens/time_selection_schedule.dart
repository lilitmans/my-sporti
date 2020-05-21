//import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
//import '../repositories/repositories.dart';
//import 'package:intl/intl.dart';
//
//class TimeSelectionSchedule extends StatefulWidget {
//  final Map<String, dynamic> club;
//  final List reservationTimeList;
//  final DateTime receivedDate;
//  final String tappedTimeForServer;
//
//  TimeSelectionSchedule(
//      {this.club,
//      this.reservationTimeList,
//      this.receivedDate,
//      this.tappedTimeForServer});
//
//  @override
//  _TimeSelectionScheduleState createState() => _TimeSelectionScheduleState();
//}
//
//class _TimeSelectionScheduleState extends State<TimeSelectionSchedule> {
//  String tappedTime;
//  Color placeTimeBackgroundColor;
//  Map<String, dynamic> thisGround;
//
//  @override
//  void initState() {
//    tappedTime = "";
////    this.widget.tappedTimeForServer = "";
//    super.initState();
//  }
//
//  void onTappedTime(Map<String, dynamic> ground, String free, String time,
//      String timeForServer) {
//    if (free != "1") return;
//
//    setState(() {
//      thisGround = ground;
//      if (tappedTime.split("|").contains(time)) {
//        tappedTime = tappedTime.replaceAll("|" + time + "|", "");
//        this
//            .widget
//            .tappedTimeForServer
//            .replaceAll("|" + timeForServer + "|", "");
//      } else {
//        tappedTime += "|" + time + "|";
//        this.widget.tappedTimeForServer += "|" + timeForServer + "|";
//      }
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    List reservationTimeList = this.widget.reservationTimeList;
//    String resTime;
//    String free;
//    String placeTime;
//    String placeTimeForServer;
//
//    return Expanded(
//      child: new ListView.builder(
//        itemCount: reservationTimeList == null ? 0 : reservationTimeList.length,
//        itemBuilder: (BuildContext context, i) {
//          String groundName = reservationTimeList[i]["name"];
//          String groundId = reservationTimeList[i]["id"];
////          print('tappedTime $tappedTime');
//          return new ListTile(
//            title: new Text("$groundName"),
//            subtitle: GridView.builder(
//                shrinkWrap: true,
//                physics: NeverScrollableScrollPhysics(),
//                itemCount: reservationTimeList[i]["times"].length,
//                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                    crossAxisCount: 4, childAspectRatio: 2.5),
//                itemBuilder: (BuildContext context, int index) {
//                  resTime = reservationTimeList[i]["times"][index]["hour"];
//                  free = reservationTimeList[i]["times"][index]["free"];
//                  placeTime = groundName + "." + resTime;
//                  placeTimeForServer = groundId + "." + resTime;
//                  var x = reservationTimeList[i]["times"][index]['hour'];
////                  print("placeTime $placeTime");
////                  print('tappedTime $tappedTime');
//
//                  placeTimeBackgroundColor = Colors.black45;
//                  if (tappedTime.split("|").contains(placeTime)) {
//                    placeTimeBackgroundColor = Colors.orange;
//                    tappedTimeList = [];
//                    tappedTimeList.add(tappedTime);
//                    print('tappedTime $tappedTime');
//                  } else if (free == "1") {
//                    placeTimeBackgroundColor = Colors.green;
//                  } else if (free == "0") {
//                    placeTimeBackgroundColor = Colors.red;
//                  }
//                  return new GestureDetector(
//                    onTap: () {
//                      onTappedTime(
//                          reservationTimeList[i],
//                          reservationTimeList[i]["times"][index]["free"],
//                          groundName +
//                              "." +
//                              reservationTimeList[i]["times"][index]["hour"],
//                          placeTimeForServer);
//                    },
//                    child: new Chip(
//                      avatar: new CircleAvatar(
//                          backgroundColor: placeTimeBackgroundColor),
//                      label: new Text('$resTime'),
//                    ),
//                  );
//                }),
//          );
//        },
//      ),
//    );
//  }
//}
