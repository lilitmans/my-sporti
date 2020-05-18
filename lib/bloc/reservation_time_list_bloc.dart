import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../repositories/repositories.dart';
import '../models/models.dart';
import '../bloc/bloc.dart';

class ReservationTimeListBloc
    extends Bloc<ReservationTimeListEvent, ReservationTimeListState> {
  final ReservationTimeListRepository reservationTimeListRepository;

  ReservationTimeListBloc({@required this.reservationTimeListRepository})
      : assert(reservationTimeListRepository != null);

  @override
  ReservationTimeListState get initialState => ReservationTimeListEmpty();

  @override
  Stream<ReservationTimeListState> mapEventToState(
      ReservationTimeListEvent event) async* {
    if (event is FetchReservationTimeList) {
      yield ReservationTimeListLoading();
      try {
        final ReservationTimeList reservationTimeList =
            await reservationTimeListRepository.fetchReservationTimeList(
                event.clubId, event.groundTypeId, event.date);
        yield ReservationTimeListLoaded(
            reservationTimeList: reservationTimeList);
      } catch (_) {
        print(_);
        yield ReservationTimeListError();
      }
    }
  }
}
