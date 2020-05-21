import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../models/models.dart';

abstract class ConfirmationResponseListState extends Equatable {
  const ConfirmationResponseListState();

  @override
  List<Object> get props => [];
}

class ConfirmationResponseListEmpty extends ConfirmationResponseListState {}

class ConfirmationResponseListLoading extends ConfirmationResponseListState {}

class ConfirmationResponseListLoaded extends ConfirmationResponseListState {
  final ConfirmationResponseList confirmationResponseList;

  const ConfirmationResponseListLoaded({@required this.confirmationResponseList}) : assert(ConfirmationResponseList != null);

  @override
  List<Object> get props => [ConfirmationResponseList];
}

class ConfirmationResponseListError extends ConfirmationResponseListState {}