import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../models/models.dart';

abstract class ClubsListState extends Equatable {
  const ClubsListState();

  @override
  List<Object> get props => [];
}

class ClubsListEmpty extends ClubsListState {}

class ClubsListLoading extends ClubsListState {}

class ClubsListLoaded extends ClubsListState {
  final ClubsList clubsList;

  const ClubsListLoaded({@required this.clubsList}) : assert(clubsList != null);

  @override
  List<Object> get props => [clubsList];
}

class ClubsListError extends ClubsListState {}
