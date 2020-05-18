import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mysporti/globals.dart';
import '../common/app_bar.dart';
import 'package:intl/intl.dart';
//import '../repositories/time_selection_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import '../screens/reservation_contact_information_screen.dart';
import '../screens/reservation-pin-screen.dart';
import '../screens/time_selection_schedule.dart';

class TimeSelectionScreen extends StatefulWidget {
  final Map<String, dynamic> club;

  TimeSelectionScreen({this.club});

  @override
  _TimeSelectionScreenState createState() => _TimeSelectionScreenState();
}

class _TimeSelectionScreenState extends State<TimeSelectionScreen> {
  DateTime date;
  String _tappedTime;
  String _tappedTimeForServer;

  _TimeSelectionScreenState();

  @override
  void initState() {
    date = DateTime.now().toLocal();
    _tappedTime = "";
    _tappedTimeForServer = DateFormat('yyyy-MM-dd – kk:mm').format(date);
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
                    receivedDate: date,
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
//              tappedTime == "" ? null : forwardToReservation();
              if (club["allow_booking"] == "1") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReservationContactInformationScreen(
                      club: this.widget.club,
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
                      reservationTimeList: reservationTimeList,
                    ),
                  ),
                );
              }
            },
            child: new Icon(Icons.arrow_forward_ios),
            backgroundColor: (_tappedTime == "" ? Colors.grey : Colors.orange),
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
