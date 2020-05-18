import 'package:shared_preferences/shared_preferences.dart';

class ReadFavorite {
  String clubFavorite;
  String clubFavoriteKey;

  void readFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clubFavorite = prefs.getString(clubFavoriteKey);
    if (clubFavorite == null) clubFavorite = "";
  }
}
