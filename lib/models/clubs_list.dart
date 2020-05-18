import 'package:equatable/equatable.dart';

class ClubsList extends Equatable {
  final List<dynamic> clubs;

  const ClubsList({this.clubs});

  @override
  List<Object> get props => [clubs];

  static ClubsList fromJson(dynamic json) {
    return ClubsList(
      clubs: json['clubs'],
    );
  }
}
