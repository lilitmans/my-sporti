import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

String mainTitle = 'mySporti';
//GlobalKey formKey;

String pinCookieKey = "clubid";
String pinCookieValue = "";

List dataRequestGetClubs;
List dataRequestGetGroundTypes;
String filter = "";
String inputVal;
//String urlBase = 'https://www.mysporti.app/?apprequest=true&';

Timer timerStartPage;
Timer timerStartPageBack;
int pageIndex = 0;
var club;
String clubId = "";
String clubName = "";
String clubAllowBooking = "";
String clubCntGroundType = "";
bool clubIsFavorite = false;
String groundTypeId = "";
String groundTypeName = "";

String tappedTime = "";
String tappedTimeForServer = "";
DateTime date = DateTime.now().toLocal();

bool obscureText = true;
String reservationPin = "";
String reservationName = "";
String reservationEmail = "";
String reservationPhone = "";

String clubFavoriteKey = 'clubFavorite';
String clubFavorite = "";
Map loopedItem;
String itemListId;
String itemListName;

List dataRequestExecuteReservation;
List dataRequestGetGrounds;
//String markAsFavoriteClubId = "";
Color placeTimeBackgroundColor;

TextEditingController editingController = TextEditingController();

String tappedTimeReadable() {
  return tappedTime.split('|').where((s) => s.isNotEmpty).join("\r\n");
}
