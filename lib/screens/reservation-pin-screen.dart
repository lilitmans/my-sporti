import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/app_bar.dart';
import '../screens/confirmation_screen.dart';
import '../repositories/repositories.dart';
import '../models/models.dart';
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
  String reservationPin;
  String dateForServer;
//  String storagePin;
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    dateForServer = DateFormat('yyyy-MM-dd').format(this.widget.date);
    if (reservationPin == null) {
      reservationPin = "";
//      _controller.text = reservationPin;
    }
    getStoragePin();
    super.initState();
  }

  void getStoragePin() async{
    String _reservationPinKey ="pin";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String getPinFromStorage = prefs.getString(_reservationPinKey);
     setState(() {
       if(getPinFromStorage == null) {
         getPinFromStorage = "";
       }
       reservationPin = getPinFromStorage;
       _controller.text = reservationPin;
     });
    print("reservationPin Get Pin: $reservationPin");
  }

  void setPin(String pin)  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _reservationPinKey ="pin";
    prefs.setString(_reservationPinKey, pin);
    var getPinFromStorage = prefs.getString(_reservationPinKey);
    print("getPinFromStorage $getPinFromStorage");
    if(getPinFromStorage == null) {
      getPinFromStorage = "";
    }
    reservationPin =  getPinFromStorage;
    _controller.text = reservationPin;
    print("reservationPin Set Pin: $reservationPin");
  }

  @override
  Widget build(BuildContext context) {
    List _tappedTimeList = tappedTimeList;

//    tappedTimeList = [];
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
                              onPressed: () {
                                setState(() {
                                  _lockIcon = !_lockIcon;
                                });
                              },
                              child: Icon(
                                  _lockIcon ? Icons.lock : Icons.lock_open),
                            ),
                          ),
                          controller: TextEditingController(text: reservationPin),
//                          initialValue: reservationPin,
                          obscureText: false,
                          validator: (value) {
//                            setState(() {
//                              AddPin(value);
//                              savePinCookie(this.widget.club["id"], value);
//                            });
                            if (value.isEmpty) {
                              return 'Bitte den PIN eintragen.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              reservationPin = value;
                              setPin(value);
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 25),

                      RaisedButton(
                        color: Colors.orange,
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKeyReservationData.currentState.validate()) {
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
