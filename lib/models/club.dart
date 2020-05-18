//import 'package:meta/meta.dart';
//import 'package:equatable/equatable.dart';

class Club {
  final String clubName;
  final String clubAddress;
  final String imgUrlBottomLeft;
  final String urlBottomLeft;
  final String imgUrlBottomRight;
  final String urlBottomRight;
  final String allowBooking;
  final String cntGroundType;
  final String groundTypeId;
  final String groundTypeDescription;
  final String clubId;

  Club({
    this.clubName,
    this.clubAddress,
    this.imgUrlBottomLeft,
    this.urlBottomLeft,
    this.imgUrlBottomRight,
    this.urlBottomRight,
    this.allowBooking,
    this.cntGroundType,
    this.groundTypeId,
    this.groundTypeDescription,
    this.clubId,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      clubName: json['name'],
      clubAddress: json['address'],
      imgUrlBottomLeft: json['image_url_bottom_left'],
      urlBottomLeft: json['url_bottom_left'],
      imgUrlBottomRight: json['image_url_bottom_right'],
      urlBottomRight: json['url_bottom_right'],
      allowBooking: json['allow_booking'].toString(),
      cntGroundType: json['cnt_ground_type'].toString(),
      groundTypeId: json['ground_type__id'].toString(),
      groundTypeDescription: json['ground_type__description'],
      clubId: json['id'].toString(),
    );
  }
}