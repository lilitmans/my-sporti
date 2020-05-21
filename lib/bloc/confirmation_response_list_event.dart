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
//  final DateTime date;
//  final DateTime tappedTimeForServer;

  const MakeRequestExecuteReservation({
    this.clubId,
    this.groundTypeId,
    this.reservationName,
    this.reservationEmail,
    this.reservationPhone,
    this.reservationPin,
//    this.date,
//    this.tappedTimeForServer,
  });

  @override
  List<Object> get props => [
        clubId,
        groundTypeId,
        reservationName,
        reservationEmail,
        reservationPhone,
        reservationPin,
//        date,
//        tappedTimeForServer,
      ];
}
