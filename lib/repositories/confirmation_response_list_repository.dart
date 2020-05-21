import 'dart:async';
import 'package:meta/meta.dart';
import '../models/models.dart';
import 'repositories.dart';

class ConfirmationResponseListRepository {
  final ConfirmationResponseListApiClient confirmationResponseListApiClient;

  ConfirmationResponseListRepository(
      {@required this.confirmationResponseListApiClient})
      : assert(confirmationResponseListApiClient != null);

  Future<ConfirmationResponseList> makeRequestExecuteReservation(
    clubId,
    groundTypeId,
    reservationName,
    reservationEmail,
    reservationPhone,
    reservationPin,
//      _date,
//      _tappedTimeForServer,
  ) async {
    return await confirmationResponseListApiClient
        .makeRequestExecuteReservation(
      clubId,
      groundTypeId,
      reservationName,
      reservationEmail,
      reservationPhone,
      reservationPin,
//      _date,
//      _tappedTimeForServer,
    );
  }
}
