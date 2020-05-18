import 'package:equatable/equatable.dart';

abstract class ReservationTimeListEvent extends Equatable {
  const ReservationTimeListEvent();
}

class FetchReservationTimeList extends ReservationTimeListEvent {
  final String clubId;
  final String groundTypeId;
  final DateTime date;
  const FetchReservationTimeList({this.clubId, this.groundTypeId, this.date});

  @override
  List<Object> get props => [clubId, groundTypeId, date];
}
