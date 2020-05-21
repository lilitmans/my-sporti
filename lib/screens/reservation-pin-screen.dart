import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/app_bar.dart';
import '../screens/confirmation_screen.dart';
import '../repositories/repositories.dart';

final formKeyReservationData = GlobalKey<FormState>();

class ReservationPinScreen extends StatefulWidget {
  final Map<String, dynamic> club;
  final List reservationTimeList;
  final String tappedTime;

  ReservationPinScreen({this.club, this.tappedTime, this.reservationTimeList});

  @override
  _ReservationPinScreenState createState() => _ReservationPinScreenState();
}

class _ReservationPinScreenState extends State<ReservationPinScreen> {
  String reservationPin;
  DateTime date;
//  String _tappedTime;
  String tappedTimeForServer;
//  MakeRequestExecuteReservation executeReservation =
//      MakeRequestExecuteReservation();

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
//    tappedTimeList = [];

    bool _lockIcon = true;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
              Text("${this.widget.club["ground_type__description"]}",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
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
              Text(""),
//              Expanded(
//                child: SizedBox(
//                  height: 200.0,
//                  child: Text("${tappedTimeList[0]}"),
//                ),
////                child: ListView.builder(
////                  itemCount: tappedTimeList == null ? 0 : tappedTimeList.length,
////                  itemBuilder: (BuildContext context, i) {
////                    return ListTile(
////                      title: Text("bul",
////                          style: TextStyle(fontWeight: FontWeight.bold)),
////                    );
////                  },
////                ),
//              ),
              SizedBox(height: 25),
              Form(
                key: formKeyReservationData,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'PIN',
                            icon: FlatButton(
                              padding: EdgeInsets.all(0.0),
                              onPressed: () {
                                setState(() {
                                  _lockIcon = !_lockIcon;
                                });
                              },
                              child: Icon(
                                  _lockIcon ? Icons.lock : Icons.lock_open),
                            ),
                          ),
                          initialValue: pinCookieValue,
                          obscureText: true,
                          validator: (value) {
                            setState(() {
                              reservationPin = value;
                            });
                            if (value.isEmpty) {
                              return 'Bitte den PIN eintragen.';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 25),
                      RaisedButton(
                        color: Colors.orange,
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (formKeyReservationData.currentState.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfirmationScreen(
                                  club: this.widget.club,
                                  groundTypeId:
                                      this.widget.club["ground_type__id"],
                                  reservationName: "",
                                  reservationEmail: "",
                                  reservationPhone: "",
                                  reservationPin: reservationPin,
                                ),
                              ),
                            );
                            setState(() {
                              savePinCookie(
                                  this.widget.club["id"], reservationPin);
                            });

//                              executeReservation();
//                            executeReservation.addData(
//                                this.widget.club["id"],
//                                this.widget.reservationTimeList,
//                                "",
//                                "",
//                                "",
//                                reservationPin,
//                                date,
//                                tappedTimeForServer);
                          } else {}
                        },
                        child: Text('Reservieren'),
                      ),
                      SizedBox(height: 50)
                    ]),
              ),

              thereIsClubImage(this.widget.club),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: new Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
