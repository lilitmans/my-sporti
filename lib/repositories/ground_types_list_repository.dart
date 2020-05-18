import 'dart:async';
import 'package:meta/meta.dart';
import '../models/models.dart';
import 'repositories.dart';

class GroundTypesListRepository {
  final ClubsListApiClient clubsListApiClient;

  GroundTypesListRepository({@required this.clubsListApiClient})
      : assert(clubsListApiClient != null);

  Future<GroundTypesList> fetchGroundTypesList(clubId) async {
    return await clubsListApiClient.fetchGroundTypesList(clubId);
  }
}
