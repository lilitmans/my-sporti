import 'package:flutter/material.dart';

thereIsClubImage(Map<String, dynamic> club) {
  if (club["image_url_bottom_left"] == "") {
    if (club["image_url_bottom_right"] == "") {
      return Container();
    } else {
      return Image.network(club["image_url_bottom_right"]);
    }
  } else {
    return Image.network(club["image_url_bottom_left"]);
  }
}
