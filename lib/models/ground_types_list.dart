import 'package:equatable/equatable.dart';

class GroundTypesList extends Equatable {
  final List<dynamic> groundTypesList;

  const GroundTypesList({this.groundTypesList});

  @override
  List<Object> get props => [groundTypesList];

  static GroundTypesList fromJson(dynamic json) {
    return GroundTypesList(
      groundTypesList: json["ground_types"],
    );
  }
}
