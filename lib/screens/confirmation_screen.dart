import 'package:flutter/material.dart';
import '../common/app_bar.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import '../repositories/repositories.dart';

class ConfirmationScreen extends StatelessWidget {
  final Map<String, dynamic> club;
  final String groundTypeId;
  final String reservationName;
  final String reservationEmail;
  final String reservationPhone;
  final String reservationPin;
  final String tappedTimeForServer;
  final String dateFormat;

  ConfirmationScreen({
        this.club,
        this.groundTypeId,
        this.reservationName,
        this.reservationEmail,
        this.reservationPhone,
        this.reservationPin,
        this.tappedTimeForServer,
        this.dateFormat});

  @override
  Widget build(BuildContext context) {
    List confirmationResponse;

    return BlocBuilder<ConfirmationResponseListBloc,
        ConfirmationResponseListState>(builder: (context, state) {
      if (state is ConfirmationResponseListEmpty) {
        BlocProvider.of<ConfirmationResponseListBloc>(context).add(
            MakeRequestExecuteReservation(
                clubId: club["id"],
                groundTypeId: groundTypeId,
                reservationName: reservationName,
                reservationEmail: reservationEmail,
                reservationPhone: reservationPhone,
                reservationPin: reservationPin,
                date: dateFormat,
                tappedTimeForServer: tappedTimeForServer,
                ));
      }

      if (state is ConfirmationResponseListError) {

        return Center(
          child: Text('Failed to fetch Reservation Confirmation List'),
        );
      }
      if (state is ConfirmationResponseListLoaded) {
        confirmationResponse = state.confirmationResponseList.confirmResult;
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: appBar(context, club["name"]),
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
                    itemCount: confirmationResponse == null
                        ? 0
                        : confirmationResponse.length,
                    itemBuilder: (BuildContext context, i) {
                      return new ListTile(
                        leading: Icon(
                            confirmationResponse[i]["result"] == "ok"
                                ? Icons.event_available
                                : Icons.event_busy,
                            color: (confirmationResponse[i]
                                        ["result"] ==
                                    "ok"
                                ? Colors.green
                                : Colors.red)),
                        title: new Text(
                            confirmationResponse[i]["description"]),
                      );
                    },
                  ),
                ),
            thereIsClubImage(club),
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
