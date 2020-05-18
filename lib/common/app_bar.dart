import 'package:flutter/material.dart';

Text appBar(BuildContext context, String title) {
  String brand = 'mySporti';
  if (title == '') {
    return Text(brand);
  } else {
    return Text(brand + ' - ' + title);
  }
}
