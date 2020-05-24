import 'package:shared_preferences/shared_preferences.dart';

String pinCookieKey = "clubid";
String pinCookieValue = "";

void readPinCookie(_clubId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  pinCookieValue = prefs.getString(pinCookieKey + _clubId);
  if (pinCookieValue == null) pinCookieValue = "";
}

void savePinCookie(_clubId, _reservationPin) async {
//  print("ID: $_clubId, PIN: $_reservationPin");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(pinCookieKey + _clubId, _reservationPin);
  print(prefs);
}


