import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import '../models/models.dart';

class MarkClubAsFavorite extends ChangeNotifier {
  List<dynamic> favoriteClubs = [];
  String _favoriteClub = "";
  String clubFavoriteKey = 'clubFavorite';
  String clubFavorite = "";
  bool clubIsFav = false;

  void readFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clubFavorite = prefs.getString(clubFavoriteKey);
    if (clubFavorite == null) clubFavorite = "";
  }

  bool isClubFavorite(String clubId) {
    if (clubId != null) {
      return _favoriteClub.contains(";" + clubId + ";");
    } else {
      return false;
    }
  }

  void markClubAsFavorite(String clubId) async {
    String _clubFavKey;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favoriteClub = prefs.getString(_clubFavKey);

    print("_clubFavKey: $_clubFavKey");
    if (_favoriteClub == null) {
      _favoriteClub = "";
      print("2 _clubFavKey1: $_clubFavKey, club: $clubId");
    }

    if (_favoriteClub.contains(";" + clubId + ";")) {
      _favoriteClub = _favoriteClub.replaceAll(";" + clubId + ";", ";");
      print("3 _clubFavKey1: $_clubFavKey, club: $clubId");
      print("3 $_favoriteClub");
    } else {
      _favoriteClub = _favoriteClub + ";" + clubId + ";";
      print("4 _clubFavKey1: $_clubFavKey, club: $clubId");
      print("4 $_favoriteClub");
    }
    _favoriteClub = _favoriteClub.replaceAll(";;", ";"); // cleanup

    prefs.setString(_clubFavKey, _favoriteClub);

    clubIsFav = _favoriteClub.contains(";" + clubId + ";");
    print("favoriteClub: $_favoriteClub");
    favoriteClubs.add(_favoriteClub);
    notifyListeners();
  }
}
