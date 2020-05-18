import 'package:equatable/equatable.dart';

class ReservationTimeList extends Equatable {
  final List<dynamic> reservationTimeList;

  const ReservationTimeList({this.reservationTimeList});

  @override
  List<Object> get props => [reservationTimeList];

  static ReservationTimeList fromJson(dynamic json) {
    return ReservationTimeList(
      reservationTimeList: json["grounds"],
    );
  }
}
