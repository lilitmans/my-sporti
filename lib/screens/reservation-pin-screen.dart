import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

final formKeyReservationData = GlobalKey<FormState>();

class ReservationPinScreen extends StatefulWidget {
  final Map<String, dynamic> club;
  final List reservationTimeList;

  ReservationPinScreen({this.club, this.reservationTimeList});

  @override
  _ReservationPinScreenState createState() => _ReservationPinScreenState();
}

class _ReservationPinScreenState extends State<ReservationPinScreen> {
  String reservationPin;
  String pinCookieKey = "clubid";
  String pinCookieValue;

  void _readPinCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    pinCookieValue = prefs.getString(pinCookieKey + this.widget.club["id"]);
    if (pinCookieValue == null) pinCookieValue = "";
  }

  @override
  Widget build(BuildContext context) {
    bool _lockIcon;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: appBar(context, this.widget.club["name"]),
      ),
//        actions: <Widget>[
//        (clubIsFavorite ? new Icon(Icons.favorite) : new Container())
//      ],);
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Name",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
              Text(" "),
              Text("AAAA",
//                  tappedTimeReadable(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 25),
              Form(
                  key: formKeyReservationData,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
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
                            reservationPin = value;
                            if (value.isEmpty) {
                              return 'Bitte den PIN eintragen.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 25),
                        RaisedButton(
                          color: Colors.orange,
                          onPressed: () {
                            // Validate returns true if the form is valid, otherwise false.
                            if (formKeyReservationData.currentState
                                .validate()) {
//                              savePinCookie();
//                              executeReservation();
                            } else {}
                          },
                          child: Text('Reservieren'),
                        ),
                        SizedBox(height: 50)
                      ])),
              Image.network(this.widget.club["image_url_bottom_left"] == ""
                  ? this.widget.club["image_url_bottom_right"]
                  : this.widget.club["image_url_bottom_left"]),
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
