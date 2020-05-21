String _tappedTime;
String _tappedTimeForServer;

void onTappedTime(Map<String, dynamic> ground, String free, String time,
    String timeForServer) {
  if (free != "1") return;

  if (_tappedTime.split("|").contains(time)) {
    _tappedTime = _tappedTime.replaceAll("|" + time + "|", "");
    _tappedTimeForServer =
        _tappedTimeForServer.replaceAll("|" + timeForServer + "|", "");
  } else {
    _tappedTime += "|" + time + "|";
    _tappedTimeForServer += "|" + timeForServer + "|";
  }
}
