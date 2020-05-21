import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/app_bar.dart';
import '../repositories/repositories.dart';
import '../screens/confirmation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import 'package:provider/provider.dart';

final formKeyReservationData = GlobalKey<FormState>();

class ReservationContactInformationScreen extends StatefulWidget {
  final Map<String, dynamic> club;
  final String groundName;
  final String tappedTime;
  final List reservationTimeList;

  ReservationContactInformationScreen(
      {this.club, this.groundName, this.tappedTime, this.reservationTimeList});

  @override
  _ReservationContactInformationScreenState createState() =>
      _ReservationContactInformationScreenState();
}

class _ReservationContactInformationScreenState
    extends State<ReservationContactInformationScreen> {
//  String _tappedTime;
  String reservationName;
  String reservationEmail;
  String reservationPhone;
  DateTime date;
  String _tappedTime;
  String tappedTimeForServer;

//  String tappedTimeReadable() {
//    return _tappedTime.split('|').where((s) => s.isNotEmpty).join("\r\n");
//  }

  @override
  void initState() {
    date = DateTime.now().toLocal();
//    _tappedTime = "";
    tappedTimeForServer = DateFormat('yyyy-MM-dd – kk:mm').format(date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List _tappedTimeList = tappedTimeList;
//    print("${this.widget.groundTypeId}");
    return Scaffold(
//        resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: appBar(context, this.widget.club["name"]),
      ),
//        actions: <Widget>[
//        (clubIsFavorite ? new Icon(Icons.favorite) : new Container())
//      ],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("${this.widget.groundName}",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
              Text(" "),
              Text(DateFormat('yyyy-MM-dd').format(date)),
//              this.widget.receivedDate
              Text(" "),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: _tappedTimeList
                    .map((i) => Text(i,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )))
                    .toList(),
              ),
              SizedBox(height: 25),
              Form(
                  key: formKeyReservationData,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Name'),
                            validator: (value) {
                              reservationName = value;
                              if (value.isEmpty) {
                                return 'Bitte den Namen eintragen.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'E-Mail Adresse'),
                            validator: (value) {
                              reservationEmail = value;
                              if (value.isEmpty) {
                                return 'Bitte die E-Mail Adresse eintragen.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Telefonnummer'),
                            validator: (value) {
                              reservationPhone = value;
                              if (value.isEmpty) {
                                return 'Bitte die Telefonnummer eintragen.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 25),
                          Text(
                              'Die Reservierung wird vorgemerkt\r\nund muss noch bestätigt werden!',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 50),
                          RaisedButton(
                            color: Colors.orange,
                            onPressed: () {
                              if (formKeyReservationData.currentState
                                  .validate()) {
//                                Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                    builder: (context) => ConfirmationScreen(
//                                        club: this.widget.club,
//                                    ""),
//                                  ),
//                                );
                              }
                            },
                            child: Text('Reservieren'),
                          ),
                        ]),
                  )),
              thereIsClubImage(this.widget.club),
            ],
          ),
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
          onPressed: _backToStartPage,
          child: new Image.asset('images/logo.png'),
        ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: new Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
