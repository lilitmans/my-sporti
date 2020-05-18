import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../repositories/repositories.dart';
import '../models/models.dart';
import '../bloc/bloc.dart';

class GroundTypesListBloc
    extends Bloc<GroundTypesListEvent, GroundTypesListState> {
  final GroundTypesListRepository groundTypesListRepository;

  GroundTypesListBloc({@required this.groundTypesListRepository})
      : assert(groundTypesListRepository != null);

  @override
  GroundTypesListState get initialState => GroundTypesListEmpty();

  @override
  Stream<GroundTypesListState> mapEventToState(
      GroundTypesListEvent event) async* {
    if (event is FetchGroundTypesList) {
      yield GroundTypesListLoading();
      try {
        final GroundTypesList groundTypesList =
            await groundTypesListRepository.fetchGroundTypesList(event.clubId);
        yield GroundTypesListLoaded(groundTypesList: groundTypesList);
      } catch (_) {
        print(_);
        yield GroundTypesListError();
      }
    }
  }
}
