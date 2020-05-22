import 'package:equatable/equatable.dart';

abstract class ConfirmationResponseListEvent extends Equatable {
  const ConfirmationResponseListEvent();
}

class MakeRequestExecuteReservation extends ConfirmationResponseListEvent {
  final String clubId;
  final String groundTypeId;
  final String reservationName;
  final String reservationEmail;
  final String reservationPhone;
  final String reservationPin;
  final String tappedTimeForServer;
  final String date;

  const MakeRequestExecuteReservation({
    this.clubId,
    this.groundTypeId,
    this.reservationName,
    this.reservationEmail,
    this.reservationPhone,
    this.reservationPin,
    this.tappedTimeForServer,
    this.date,
  });

//  clubId: club["id"],+
//  reservationName: reservationName,+
//  reservationEmail: reservationEmail,+
//  reservationPhone: reservationPhone,+
//  reservationPin: reservationPin,+
//  date: _dateForServer,+
//  tappedTimeForServer: tappedTimeForServer,+

  @override
  List<Object> get props => [
        clubId,
        groundTypeId,
        reservationName,
        reservationEmail,
        reservationPhone,
        reservationPin,
    tappedTimeForServer,
        date,
      ];
}
