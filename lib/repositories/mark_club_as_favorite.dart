import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import '../models/models.dart';

class MarkClubAsFavorite extends ChangeNotifier {
  List<dynamic> favoriteClubs = [];
  String _favoriteClub = "";
  String clubFavoriteKey = 'clubFavorite';
  String clubFavorite = "";
  bool clubIsFav;

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
//    bool clubIsFav = false;
    String _clubFavKey;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favoriteClub = prefs.getString(_clubFavKey);

    if (_favoriteClub == null) {
      _favoriteClub = "";
    }

    if (_favoriteClub.contains(";" + clubId + ";")) {
      _favoriteClub = _favoriteClub.replaceAll(";" + clubId + ";", ";");
      print("3 $_favoriteClub");
    } else {
      _favoriteClub = _favoriteClub + ";" + clubId + ";";
      print("4 $_favoriteClub");
    }
    _favoriteClub = _favoriteClub.replaceAll(";;", ";"); // cleanup

    prefs.setString(_clubFavKey, _favoriteClub);

    clubIsFav = _favoriteClub.contains(";" + clubId + ";");
    print("5 $_favoriteClub $clubIsFav");
//    favoriteClubs.add(value);
    notifyListeners();
  }

//

}
