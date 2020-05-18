import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../repositories/repositories.dart';
import '../models/models.dart';
import '../bloc/bloc.dart';

class ClubsListBloc extends Bloc<ClubsListEvent, ClubsListState> {
  final ClubsListRepository clubsListRepository;

  ClubsListBloc({@required this.clubsListRepository})
      : assert(clubsListRepository != null);

  @override
  ClubsListState get initialState => ClubsListEmpty();

  @override
  Stream<ClubsListState> mapEventToState(ClubsListEvent event) async* {
    if (event is FetchClubsList) {
      yield ClubsListLoading();
      try {
        final ClubsList clubsList = await clubsListRepository.fetchClubsList();
        yield ClubsListLoaded(clubsList: clubsList);
      } catch (_) {
        print(_);
        yield ClubsListError();
      }
    }
  }
}
