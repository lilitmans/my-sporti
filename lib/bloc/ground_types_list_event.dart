import 'package:equatable/equatable.dart';

abstract class GroundTypesListEvent extends Equatable {
  const GroundTypesListEvent();
}

class FetchGroundTypesList extends GroundTypesListEvent {
  final String clubId;
  const FetchGroundTypesList({this.clubId});

  @override
  List<Object> get props => [clubId];
}
