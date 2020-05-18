import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:collection';

class MakeRequestGetClubs extends ChangeNotifier {
  var clubs = List<dynamic>();

  Future<List<dynamic>> makeRequestGetClubs() async {
    String urlBase = 'https://www.mysporti.app/?app_request=true&';
    var response = await http.get(Uri.encodeFull(urlBase + 'get_clubs=true'),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      var receivedClubList = json.decode(response.body)["clubs"];
      for (var club in receivedClubList) {
        clubs.add(club);
      }
      return clubs;
    } else {
      throw Exception('Failed to load clubs.');
    }
  }

  Future<void> getData() async {
    await makeRequestGetClubs();
    notifyListeners();
  }
}
