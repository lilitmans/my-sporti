import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/app_bar.dart';
import '../repositories/repositories.dart';
import '../screens/confirmation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

final formKeyReservationData = GlobalKey<FormState>();

class ReservationContactInformationScreen extends StatefulWidget {
  final Map<String, dynamic> club;
  final String groundName;
  final List reservationTimeList;
  final DateTime date;
  final String tappedTimeForServer;

  ReservationContactInformationScreen(
      {this.club, this.groundName, this.reservationTimeList, this.date, this.tappedTimeForServer});

  @override
  _ReservationContactInformationScreenState createState() =>
      _ReservationContactInformationScreenState();
}

class _ReservationContactInformationScreenState
    extends State<ReservationContactInformationScreen> {
  String cookieKey = "clubId";
  String reservationName;
  String reservationEmail;
  String reservationPhone;
  String dateForServer;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();

  @override
  void initState() {
    dateForServer = DateFormat('yyyy-MM-dd').format( this.widget.date);
    _readCookie();
    _readFavorite();
    super.initState();
  }

  void _readCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    reservationName = prefs.getString("name_"+cookieKey+widget.club["id"]);
    reservationEmail = prefs.getString("email_"+cookieKey+widget.club["id"]);
    reservationPhone = prefs.getString("phone_"+cookieKey+widget.club["id"]);
    if(reservationName == null || reservationEmail == null || reservationPhone == null) {
      reservationName = "";
      reservationEmail = "";
      reservationPhone = "";
    }
    setState(() {
      _nameController = new TextEditingController(text: reservationName);
      _emailController = new TextEditingController(text: reservationEmail);
      _phoneController = new TextEditingController(text: reservationPhone);
    });
  }

  void _saveCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString("name_"+cookieKey+widget.club['id'], reservationName);
      prefs.setString("email_"+cookieKey+widget.club['id'], reservationEmail);
      prefs.setString("phone_"+cookieKey+widget.club['id'], reservationPhone);
    });
  }

  bool _clubIsFav = false;
  String clubFavoriteKey = 'clubFavorite';
  String clubFavorite = "";
  void _readFavorite() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clubFavorite = prefs.getString(clubFavoriteKey);
    if(clubFavorite==null) clubFavorite = "";
    isClubFavorite();
  }

  isClubFavorite() {
    setState(() {
      _clubIsFav = clubFavorite.contains(";"+this.widget.club["id"]+";");
    });
  }

  @override
  Widget build(BuildContext context) {
    List _tappedTimeList = tappedTimeList;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: appBar(context, this.widget.club["name"]),
        actions: <Widget>[
          (_clubIsFav ? new Icon(Icons.favorite) : new Container())
        ],),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(" "),
              Text("${this.widget.groundName}",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
              Text(" "),
              Text(DateFormat('yyyy-MM-dd').format(this.widget.date)),
              Text(" "),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: _tappedTimeList
                    .map((i) => Center(
                  child: Text(i.replaceAll("|","\n"),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ))
                    .toList(),
              ),
              Form(
                  key: formKeyReservationData,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Name'),
                            controller: _nameController,
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
                            controller: _emailController,
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
                            controller: _phoneController,
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
                                _saveCookie();
                                Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfirmationScreen(
                                  club: widget.club,
                                  groundTypeId:
                                      this.widget.club["ground_type__id"],
                                  reservationName: reservationName,
                                  reservationEmail: reservationEmail,
                                  reservationPhone: reservationPhone,
                                  reservationPin: "",
                                  tappedTimeForServer: this.widget.tappedTimeForServer,
                                  dateFormat: dateForServer,
                                ),
                              ),
                            );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: new Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
