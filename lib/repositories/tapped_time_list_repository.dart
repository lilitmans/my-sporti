var tappedTimeList = [];

String tappedTimeReadable(_tappedTime) {
  return _tappedTime.split('|').where((s) => s.isNotEmpty).join("\r\n");
}
