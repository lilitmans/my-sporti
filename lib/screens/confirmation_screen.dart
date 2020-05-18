import 'package:flutter/material.dart';
import '../common/app_bar.dart';

class ConfirmationScreen extends StatelessWidget {
  ConfirmationScreen({this.backToStartPage});
  final VoidCallback backToStartPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: appBar(context, 'clubName'), actions: <Widget>[
        (clubIsFavorite ? new Icon(Icons.favorite) : new Container())
      ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: dataRequestExecuteReservation == null
                    ? 0
                    : dataRequestExecuteReservation.length,
                itemBuilder: (BuildContext context, i) {
                  return new ListTile(
                    leading: Icon(
                        dataRequestExecuteReservation[i]["result"] == "ok"
                            ? Icons.event_available
                            : Icons.event_busy,
                        color:
                            (dataRequestExecuteReservation[i]["result"] == "ok"
                                ? Colors.green
                                : Colors.red)),
                    title: new Text(
                        dataRequestExecuteReservation[i]["description"]),
                  );
                },
              ),
            ),
            new Image.network(club["image_url_bottom_left"] == ""
                ? club["image_url_bottom_right"]
                : club["image_url_bottom_left"]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: backToStartPage,
        child: new Image.asset('images/logo.png'),
      ),
    );
  }
}
