import 'package:shared_preferences/shared_preferences.dart';

class MarkAsFavorite {
  String clubId;
  String clubFavorite;
  String clubFavoriteKey;
  bool clubIsFavorite;

  void markAsFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clubFavorite = prefs.getString(clubFavoriteKey);
    if (clubFavorite == null) clubFavorite = "";

    if (clubFavorite.contains(";" + clubId + ";")) {
      clubFavorite = clubFavorite.replaceAll(";" + clubId + ";", ";");
    } else {
      clubFavorite = clubFavorite + ";" + clubId + ";";
    }
    clubFavorite = clubFavorite.replaceAll(";;", ";"); // cleanup

    prefs.setString(clubFavoriteKey, clubFavorite);

    clubIsFavorite = clubFavorite.contains(";" + clubId + ";");
  }
}
