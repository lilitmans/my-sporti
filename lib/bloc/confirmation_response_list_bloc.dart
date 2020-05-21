import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../repositories/repositories.dart';
import '../models/models.dart';
import '../bloc/bloc.dart';

class ConfirmationResponseListBloc
    extends Bloc<ConfirmationResponseListEvent, ConfirmationResponseListState> {
  final ConfirmationResponseListRepository confirmationResponseListRepository;

  ConfirmationResponseListBloc(
      {@required this.confirmationResponseListRepository})
      : assert(confirmationResponseListRepository != null);

  @override
  ConfirmationResponseListState get initialState =>
      ConfirmationResponseListEmpty();

  @override
  Stream<ConfirmationResponseListState> mapEventToState(
      ConfirmationResponseListEvent event) async* {
    if (event is MakeRequestExecuteReservation) {
      yield ConfirmationResponseListLoading();
      try {
        final ConfirmationResponseList confirmationResponseList =
            await confirmationResponseListRepository
                .makeRequestExecuteReservation(
          event.clubId,
          event.groundTypeId,
          event.reservationName,
          event.reservationEmail,
          event.reservationPhone,
          event.reservationPin,
//          event._date,
//          event._tappedTimeForServer,
        );
        yield ConfirmationResponseListLoaded(
            confirmationResponseList: confirmationResponseList);
      } catch (_) {
        print(_);
        yield ConfirmationResponseListError();
      }
    }
  }
}
