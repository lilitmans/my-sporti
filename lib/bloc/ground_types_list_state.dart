import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../models/models.dart';

abstract class GroundTypesListState extends Equatable {
  const GroundTypesListState();

  @override
  List<Object> get props => [];
}

class GroundTypesListEmpty extends GroundTypesListState {}

class GroundTypesListLoading extends GroundTypesListState {}

class GroundTypesListLoaded extends GroundTypesListState {
  final GroundTypesList groundTypesList;

  const GroundTypesListLoaded({@required this.groundTypesList})
      : assert(groundTypesList != null);

  @override
  List<Object> get props => [groundTypesList];
}

class GroundTypesListError extends GroundTypesListState {}
