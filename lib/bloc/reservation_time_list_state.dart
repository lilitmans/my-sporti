import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../models/models.dart';

abstract class ReservationTimeListState extends Equatable {
  const ReservationTimeListState();

  @override
  List<Object> get props => [];
}

class ReservationTimeListEmpty extends ReservationTimeListState {}

class ReservationTimeListLoading extends ReservationTimeListState {}

class ReservationTimeListLoaded extends ReservationTimeListState {
  final ReservationTimeList reservationTimeList;

  const ReservationTimeListLoaded({@required this.reservationTimeList})
      : assert(reservationTimeList != null);

  @override
  List<Object> get props => [reservationTimeList];
}

class ReservationTimeListError extends ReservationTimeListState {}
