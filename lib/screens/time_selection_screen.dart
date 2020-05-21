import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../common/app_bar.dart';
import 'package:intl/intl.dart';
import '../repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import '../screens/reservation_contact_information_screen.dart';
import '../screens/reservation-pin-screen.dart';
import '../screens/time_selection_schedule.dart';
import 'package:provider/provider.dart';

_TimeSelectionScreenState _globalState  = _TimeSelectionScreenState();

class TimeSelectionScreen extends StatefulWidget {
  final Map<String, dynamic> club;
  final String groundName;

  TimeSelectionScreen({this.club, this.groundName});

  @override
  _TimeSelectionScreenState createState() => _TimeSelectionScreenState();
}

class _TimeSelectionScreenState extends State<TimeSelectionScreen> {
  DateTime date;
  String _tappedTime;
  String tappedTimeForServer;

  _TimeSelectionScreenState();

  @override
  void initState() {
    date = DateTime.now().toLocal();
    _tappedTime = "";
    tappedTimeForServer = DateFormat('yyyy-MM-dd – kk:mm').format(date);
    super.initState();
  }

  thereIsClubImage() {
    if (this.widget.club["image_url_bottom_left"] == "") {
      if (this.widget.club["image_url_bottom_right"] == "") {
        return Container();
      } else {
        return Image.network(this.widget.club["image_url_bottom_right"]);
      }
    } else {
      return Image.network(this.widget.club["image_url_bottom_left"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    List reservationTimeList;

    return Scaffold(
      appBar: AppBar(
        title: appBar(context, this.widget.club["name"]),
      ),
//        actions: <Widget>[
//        (clubIsFavorite ? new Icon(Icons.favorite) : new Container())
//      ],);
      body: BlocBuilder<ReservationTimeListBloc, ReservationTimeListState>(
        builder: (context, state) {
          if (state is ReservationTimeListEmpty) {
            BlocProvider.of<ReservationTimeListBloc>(context).add(
                FetchReservationTimeList(
                    clubId: this.widget.club["id"],
                    groundTypeId: this.widget.club["ground_type__id"],
                    date: date));
          }
          if (state is ReservationTimeListError) {
            return Center(
              child: Text('Failed to fetch reservation time list'),
            );
          }
          if (state is ReservationTimeListLoaded) {
            reservationTimeList = state.reservationTimeList.reservationTimeList;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onConfirm: (d) {
                        setState(() {
                          date = d.toLocal();
                          _tappedTime =
                              DateFormat('yyyy-MM-dd – kk:mm').format(date);

                          BlocProvider.of<ReservationTimeListBloc>(context).add(
                              FetchReservationTimeList(
                                  clubId: this.widget.club["id"],
                                  groundTypeId:
                                      this.widget.club["ground_type__id"],
                                  date: date));
                        });
                      }, currentTime: date, locale: LocaleType.de);
                    },
                    child: Column(children: <Widget>[
                      Text("Datum und Uhrzeit auswählen"),
                      Text(_tappedTime == ""
                          ? DateFormat('yyyy-MM-dd – kk:mm').format(date)
                          : _tappedTime)
                    ]),
                  ),
                  TimeSelectionSchedule(
                    club: this.widget.club,
                    reservationTimeList: reservationTimeList,
                  ),
                  thereIsClubImage(),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'btn3',
            onPressed: () {
              if (tappedTimeList.length != 0) {
                if (this.widget.club["allow_booking"] == "1") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReservationContactInformationScreen(
                        club: this.widget.club,
                        groundName: this.widget.groundName,
                        tappedTime: _tappedTime,
                        reservationTimeList: reservationTimeList,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReservationPinScreen(
                        club: this.widget.club,
                        tappedTime: _tappedTime,
                        reservationTimeList: reservationTimeList,
                      ),
                    ),
                  );
                }
              }
            },
            child: new Icon(Icons.arrow_forward_ios),
            backgroundColor:
                (tappedTimeList.length == 0 ? Colors.grey : Colors.orange),
          ),
          FloatingActionButton(
            heroTag: 'btn4',
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Icon(Icons.arrow_back_ios),
          ),
        ],
      ),
    );
  }
}

// Time Selection Schedule .....................................................

class TimeSelectionSchedule extends StatefulWidget {
  final Map<String, dynamic> club;
  final List reservationTimeList;

  TimeSelectionSchedule(
      {this.club, this.reservationTimeList});

  @override
  _TimeSelectionScheduleState createState() => _TimeSelectionScheduleState();
}

class _TimeSelectionScheduleState extends State<TimeSelectionSchedule> {
  String tappedTime;
  Color placeTimeBackgroundColor;
  Map<String, dynamic> thisGround;

  @override
  void initState() {
    tappedTime = "";
//    this.widget.tappedTimeForServer = "";
    super.initState();
  }

  void onTappedTime(Map<String, dynamic> ground, String free, String time,
      String timeForServer) {
    if (free != "1") return;

    _globalState.setState(() {
      thisGround = ground;
      if (tappedTime.split("|").contains(time)) {
        tappedTime = tappedTime.replaceAll("|" + time + "|", "");
        _globalState.tappedTimeForServer =  _globalState.tappedTimeForServer
            .replaceAll("|" + timeForServer + "|", "");
        print(_globalState.tappedTimeForServer);
      } else {
        tappedTime += "|" + time + "|";
        _globalState.tappedTimeForServer += "|" + timeForServer + "|";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List reservationTimeList = this.widget.reservationTimeList;
    String resTime;
    String free;
    String placeTime;
    String placeTimeForServer;

    return Expanded(
      child: new ListView.builder(
        itemCount: reservationTimeList == null ? 0 : reservationTimeList.length,
        itemBuilder: (BuildContext context, i) {
          String groundName = reservationTimeList[i]["name"];
          String groundId = reservationTimeList[i]["id"];
//          print('tappedTime $tappedTime');
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
                  var x = reservationTimeList[i]["times"][index]['hour'];
//                  print("placeTime $placeTime");
//                  print('tappedTime $tappedTime');

                  placeTimeBackgroundColor = Colors.black45;
                  if (tappedTime.split("|").contains(placeTime)) {
                    placeTimeBackgroundColor = Colors.orange;
                    tappedTimeList = [];
                    tappedTimeList.add(tappedTime);
                    print('tappedTime $tappedTime');
                  } else if (free == "1") {
                    placeTimeBackgroundColor = Colors.green;
                  } else if (free == "0") {
                    placeTimeBackgroundColor = Colors.red;
                  }
                  return new GestureDetector(
                    onTap: () {
                      onTappedTime(
                          reservationTimeList[i],
                          reservationTimeList[i]["times"][index]["free"],
                          groundName +
                              "." +
                              reservationTimeList[i]["times"][index]["hour"],
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

