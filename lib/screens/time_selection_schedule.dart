import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TimeSelectionSchedule extends StatefulWidget {
  final Map<String, dynamic> club;
  final List reservationTimeList;
  final DateTime receivedDate;

  TimeSelectionSchedule(
      {this.club, this.reservationTimeList, this.receivedDate});

  @override
  _TimeSelectionScheduleState createState() => _TimeSelectionScheduleState();
}

class _TimeSelectionScheduleState extends State<TimeSelectionSchedule> {
  String tappedTime;
  String tappedTimeForServer;
  Color placeTimeBackgroundColor;

  @override
  void initState() {
    tappedTime =
        DateFormat('yyyy-MM-dd – kk:mm').format(this.widget.receivedDate);
    tappedTimeForServer =
        DateFormat('yyyy-MM-dd – kk:mm').format(this.widget.receivedDate);
    super.initState();
  }

  void onTappedTime(Map<String, dynamic> ground, String free, String time,
      String timeForServer) {
    if (free != "1") return;

    setState(() {
      //this.makeRequestGetClubs();
      if (tappedTime.split("|").contains(time)) {
        tappedTime = tappedTime.replaceAll("|" + time + "|", "");
        tappedTimeForServer =
            tappedTimeForServer.replaceAll("|" + timeForServer + "|", "");
      } else {
        tappedTime += "|" + time + "|";
        tappedTimeForServer += "|" + timeForServer + "|";
      }
    });
  }

//  String tappedTimeReadable() {
//    return tappedTime.split('|').where((s) => s.isNotEmpty).join("\r\n");
//  }

  @override
  Widget build(BuildContext context) {
    List reservationTimeList = this.widget.reservationTimeList;
    String resTime;
    String free;
    String placeTime;
    String placeTimeForServer;
    List tappedTimeList;

    return Expanded(
      child: new ListView.builder(
        itemCount: reservationTimeList == null ? 0 : reservationTimeList.length,
        itemBuilder: (BuildContext context, i) {
          String groundName = reservationTimeList[i]["name"];
          String groundId = reservationTimeList[i]["id"];

          return new ListTile(
            title: new Text("$groundName"),
            subtitle: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: reservationTimeList[i]["times"].length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, childAspectRatio: 2.5),
                itemBuilder: (BuildContext context, int index) {
                  resTime = reservationTimeList[i]["times"][index]["hour"];
                  free = reservationTimeList[i]["times"][index]["free"];
                  placeTime = groundName + "." + resTime;
                  placeTimeForServer = groundId + "." + resTime;

                  placeTimeBackgroundColor = Colors.black45;
                  if (tappedTime.split("|").contains(placeTime)) {
                    placeTimeBackgroundColor = Colors.orange;
//                    tappedTimeList.add(tappedTime);
                  } else if (free == "1") {
                    placeTimeBackgroundColor = Colors.green;
                  } else if (free == "0") {
                    placeTimeBackgroundColor = Colors.red;
                  }
                  return new GestureDetector(
                    onTap: () {
                      onTappedTime(reservationTimeList[i], free, placeTime,
                          placeTimeForServer);
                    },
                    child: new Chip(
                      avatar: new CircleAvatar(
                          backgroundColor: placeTimeBackgroundColor),
                      label: new Text('$resTime'),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
