import 'package:equatable/equatable.dart';

class ConfirmationResponseList extends Equatable {
  final List<dynamic> confirmResult;

  const ConfirmationResponseList({this.confirmResult});

  @override
  List<Object> get props => [confirmResult];

  static ConfirmationResponseList fromJson(dynamic json) {
    return ConfirmationResponseList(
      confirmResult: json['reservation_result'],
    );
  }
}
