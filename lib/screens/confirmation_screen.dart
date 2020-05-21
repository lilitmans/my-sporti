import 'package:flutter/material.dart';
import '../common/app_bar.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';

class ConfirmationScreen extends StatelessWidget {
//  final Map<String, dynamic> confirmationResponseList;
  final Map<String, dynamic> club;
  final String groundTypeId;
  final String reservationName;
  final String reservationEmail;
  final String reservationPhone;
  final String reservationPin;
//  final Map<String, dynamic> dataRequestExecuteReservation;

  ConfirmationScreen(
      {this.club,
      this.groundTypeId,
      this.reservationName,
      this.reservationEmail,
      this.reservationPhone,
      this.reservationPin});

  @override
  Widget build(BuildContext context) {
    List dataRequestExecuteReservation;
//        Provider.of<MakeRequestExecuteReservation>(context).returnResponse();
    return BlocBuilder<ConfirmationResponseListBloc,
        ConfirmationResponseListState>(builder: (context, state) {
      if (state is ConfirmationResponseListEmpty) {
        BlocProvider.of<ConfirmationResponseListBloc>(context).add(
            MakeRequestExecuteReservation(
                clubId: club["id"],
                reservationName: reservationName,
                reservationEmail: reservationEmail,
                reservationPhone: reservationPhone,
                reservationPin: reservationPin
//    "",
//    date,
//   tappedTimeForServer
                ));
        print(
            "ID: ${club["id"]}, GROUND_ID: $groundTypeId, NAME: $reservationName, EMAIL: $reservationEmail, PHONE: $reservationPhone, PIN: $reservationPin");
      }
      if (state is ConfirmationResponseListError) {
        return Center(
          child: Text('Failed to fetch Reservation Confirmation List'),
        );
      }
      if (state is ConfirmationResponseListLoaded) {
        return Scaffold(
          appBar: AppBar(
//        title: appBar(context, club["name"]),
              ),
//        actions: <Widget>[
//        (clubIsFavorite ? new Icon(Icons.favorite) : new Container())
//      ],);
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: dataRequestExecuteReservation == null
                        ? 0
                        : dataRequestExecuteReservation.length,
                    itemBuilder: (BuildContext context, i) {
                      return new ListTile(
                        leading: Icon(
                            dataRequestExecuteReservation[i]["result"] == "ok"
                                ? Icons.event_available
                                : Icons.event_busy,
                            color: (dataRequestExecuteReservation[i]
                                        ["result"] ==
                                    "ok"
                                ? Colors.green
                                : Colors.red)),
                        title: new Text(
                            dataRequestExecuteReservation[i]["description"]),
                      );
                    },
                  ),
                ),
//            thereIsClubImage(club),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Phoenix.rebirth(context);
            },
            child: new Image.asset('images/logo.png'),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
