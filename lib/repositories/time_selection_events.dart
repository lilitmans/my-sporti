String _tappedTime;
String _tappedTimeForServer;

void onTappedTime(Map<String, dynamic> ground, String free, String time,
    String timeForServer) {
  if (free != "1") return;

  //_showDialog("onTappedTime - time = [" + time + "]");

  //this.makeRequestGetClubs();
//      print(
//          "111 tappedTime $tappedTime tappedTimeForServer $tappedTimeForServer");

  if (_tappedTime.split("|").contains(time)) {
    _tappedTime = _tappedTime.replaceAll("|" + time + "|", "");
    _tappedTimeForServer =
        _tappedTimeForServer.replaceAll("|" + timeForServer + "|", "");
//        print(
//            "222 tappedTime $tappedTime tappedTimeForServer $tappedTimeForServer");
  } else {
    _tappedTime += "|" + time + "|";
    _tappedTimeForServer += "|" + timeForServer + "|";

//        print(
//            "333 tappedTime $tappedTime tappedTimeForServer $tappedTimeForServer");
  }
}
