import 'dart:async';
import 'package:meta/meta.dart';
import '../models/models.dart';
import 'repositories.dart';

class ReservationTimeListRepository {
  final ClubsListApiClient clubsListApiClient;

  ReservationTimeListRepository({@required this.clubsListApiClient})
      : assert(clubsListApiClient != null);

  Future<ReservationTimeList> fetchReservationTimeList(
      clubId, groundTypeId, date) async {
    return await clubsListApiClient.fetchReservationTimeList(
        clubId, groundTypeId, date);
  }
}
