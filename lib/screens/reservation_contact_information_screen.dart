import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/app_bar.dart';

final formKeyReservationData = GlobalKey<FormState>();

String tappedTimeReadable() {
  return tappedTime.split('|').where((s) => s.isNotEmpty).join("\r\n");
}

class ReservationContactInformationScreen extends StatelessWidget {
  final Map<String, dynamic> club;
  final List reservationTimeList;

  ReservationContactInformationScreen({this.club, this.reservationTimeList});

  @override
  Widget build(BuildContext context) {
    String reservationName;

    return Scaffold(
//        resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: appBar(context, club["name"]),
      ),
//        actions: <Widget>[
//        (clubIsFavorite ? new Icon(Icons.favorite) : new Container())
//      ],);
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('reservationTimeList["name"]',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
              Text(" "),
              Text(DateFormat('yyyy-MM-dd').format(date)),
              Text(" "),
              Text(tappedTimeReadable(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 25),
              Form(
                  key: formKeyReservationData,
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
                        RaisedButton(
                          color: Colors.orange,
                          onPressed: () {
                            // Validate returns true if the form is valid, otherwise false.
                            if (formKeyReservationData.currentState
                                .validate()) {
//                              executeReservation();
                            }
                          },
                          child: Text('Reservieren'),
                        ),
                        SizedBox(height: 50)
                      ])),
              new Image.network(club["image_url_bottom_left"] == ""
                  ? club["image_url_bottom_right"]
                  : club["image_url_bottom_left"]),
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
