import 'package:equatable/equatable.dart';

abstract class ClubsListEvent extends Equatable {
  const ClubsListEvent();
}

class FetchClubsList extends ClubsListEvent {
  const FetchClubsList();

  @override
  List<Object> get props => [];
}
