import 'package:flutter/material.dart';

thereIsClubImage(Map<String, dynamic> club) {
  if (club["image_url_bottom_left"] == "" || club["image_url_bottom_left"].split(":")[0] != "F") {
    if (club["image_url_bottom_right"] == "" || club["image_url_bottom_right"].split(":")[0] != "F") {
      return Container();
    } else {
      return Image.network(club["image_url_bottom_right"]);
    }
  } else {
    return Image.network(club["image_url_bottom_left"]);
  }
}
