import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:mysporti/models/models.dart';
import 'package:meta/meta.dart';
import '../models/models.dart';

class ConfirmationResponseListApiClient {
  final _baseUrl = 'https://www.mysporti.app';
  final http.Client httpClient;
//  String _clubId;
//  String _groundTypeId;
//  String _reservationName;
//  String _reservationEmail;
//  String _reservationPhone;
//  String _reservationPin;
//  DateTime _date;
//  String _tappedTimeForServer;

  ConfirmationResponseListApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<ConfirmationResponseList> makeRequestExecuteReservation(
    _clubId,
    _groundTypeId,
    _reservationName,
    _reservationEmail,
    _reservationPhone,
    _reservationPin,
      _tappedTimeForServer,
      _date,
  ) async {

    ConfirmationResponseList confirmationResponseList;

    String urlParams = "";
    urlParams += "&id_club=" + _clubId;
    urlParams += "&id_ground_type=" + _groundTypeId;
    urlParams += "&reservationName=" + base64.encode(utf8.encode(_reservationName));
    urlParams += "&reservationEmail=" + base64.encode(utf8.encode(_reservationEmail));
    urlParams += "&reservationPhone=" + base64.encode(utf8.encode(_reservationPhone));
    urlParams += "&reservationPin=" + base64.encode(utf8.encode(_reservationPin));
    urlParams += "&date=" + base64.encode(utf8.encode(_date));
    urlParams += "&tappedTime=" + base64.encode(utf8.encode(_tappedTimeForServer));

    var response = await http.get(Uri.encodeFull(_baseUrl +'/?app_request=true&execute_reservation=true'+urlParams), headers: {"Accept": "application/json"});
//    var url = Uri.encodeFull(_baseUrl +'?app_request=true&execute_reservation=true'+urlParams);
//    print("response: $url");

    if (response.statusCode != 200) {
      throw new Exception(
          'Error getting Confirmation Reservation Response List');
    }

    final json = jsonDecode(response.body);
    confirmationResponseList = ConfirmationResponseList.fromJson(json);
//    print("ConfirmationResponseList: $confirmationResponseList");
    return confirmationResponseList;
  }

//  returnResponse() {
//    return confirmationResponseList;
//  }
}

//class MakeRequestExecuteReservation extends ChangeNotifier {
//  ConfirmationResponseList dataRequestExecuteReservation;
//  String _clubId;
//  String _groundTypeId;
//  String _reservationName;
//  String _reservationEmail;
//  String _reservationPhone;
//  String _reservationPin;
//  DateTime _date;
//  String _tappedTimeForServer;
//
//  addData(clId, _groundId, _resName, _resEmail, _resPhone, _resPin, _d,
//      _timeServer) async {
//    _clubId = clId;
//    _groundTypeId = _groundId;
//    _reservationName = _resName;
//    _reservationEmail = _resEmail;
//    _reservationPhone = _resPhone;
//    _reservationPin = _resPin;
//    _date = _d;
//    _tappedTimeForServer = _timeServer;
//    return await makeRequestExecuteReservation();
//  }
//
//  Future<ConfirmationResponseList> makeRequestExecuteReservation() async {
////  Dialogs.showLoadingDialog(context, _keyLoader);
//
//    String baseUrl = 'https://www.mysporti.app';
//
//    String urlParams = "";
//    urlParams += "&id_club=" + _clubId;
//    urlParams += "&id_ground_type=" + _groundTypeId;
//    urlParams +=
//        "&reservationName=" + base64.encode(utf8.encode(_reservationName));
//    urlParams +=
//        "&reservationEmail=" + base64.encode(utf8.encode(_reservationEmail));
//    urlParams +=
//        "&reservationPhone=" + base64.encode(utf8.encode(_reservationPhone));
//    urlParams +=
//        "&reservationPin=" + base64.encode(utf8.encode(_reservationPin));
//    urlParams += "&date=" +
//        base64.encode(utf8.encode(DateFormat('yyyy-MM-dd').format(_date)));
//    urlParams +=
//        "&tappedTime=" + base64.encode(utf8.encode(_tappedTimeForServer));
//
//    final response = await http.get(
//        Uri.encodeFull(baseUrl + 'execute_reservation=true' + urlParams),
//        headers: {"Accept": "application/json"});
//
//    final extractData = json.decode(response.body);
//    dataRequestExecuteReservation = extractData["reservation_result"];
//    print("$dataRequestExecuteReservation");
//
//    return dataRequestExecuteReservation;
////  Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
//  }
//
//  returnResponse() async {
//    await makeRequestExecuteReservation();
//    notifyListeners();
//  }
//}
