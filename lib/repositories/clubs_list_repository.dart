import 'dart:async';
import 'package:meta/meta.dart';
import '../models/models.dart';
import 'repositories.dart';

class ClubsListRepository {
  final ClubsListApiClient clubsListApiClient;

  ClubsListRepository({@required this.clubsListApiClient})
      : assert(clubsListApiClient != null);

  Future<ClubsList> fetchClubsList() async {
    return await clubsListApiClient.fetchClubsList();
  }
}
