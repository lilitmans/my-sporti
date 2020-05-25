import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/app_bar.dart';
import '../screens/confirmation_screen.dart';
import '../repositories/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _formKeyReservationData = GlobalKey<FormState>();

class ReservationPinScreen extends StatefulWidget {
  final Map<String, dynamic> club;
  final List reservationTimeList;
  final DateTime date;
  final String tappedTimeForServer;

  ReservationPinScreen({this.club, this.date, this.tappedTimeForServer, this.reservationTimeList});

  @override
  _ReservationPinScreenState createState() => _ReservationPinScreenState();
}

class _ReservationPinScreenState extends State<ReservationPinScreen> {
  String pinCookieKey = "clubId";
  String reservationPin = "";
  String dateForServer;
  TextEditingController _pinController = new TextEditingController();

  @override
  void initState() {
    dateForServer = DateFormat('yyyy-MM-dd').format(this.widget.date);
    _readPinCookie();
    super.initState();
  }

  void _readPinCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    reservationPin = prefs.getString(pinCookieKey+widget.club["id"]);
    if(reservationPin==null) reservationPin = "";
    setState(() {
      _pinController = new TextEditingController(text: reservationPin);
    });
  }

  void _savePinCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString(pinCookieKey+widget.club['id'], reservationPin);
    });
  }

  @override
  Widget build(BuildContext context) {
    List _tappedTimeList = tappedTimeList;
    bool _lockIcon = true;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,

                children: _tappedTimeList
                    .map((i) => Center(
                      child: Text(i.replaceAll("|","\n"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                    ))
                    .toList(),
              ),
              Text(""),
              SizedBox(height: 25),
              Form(
                key: _formKeyReservationData,
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
                              child: Icon(
                                  _lockIcon ? Icons.lock : Icons.lock_open),
                            ),
                          ),
                          controller: _pinController,
                          obscureText: true,
                          validator: (value) {
                            reservationPin = value;
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
                          if (_formKeyReservationData.currentState.validate()) {
                            _savePinCookie();
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
                                  tappedTimeForServer: this.widget.tappedTimeForServer,
                                  dateFormat: dateForServer,
                                ),
                              ),
                            );
                          }
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
