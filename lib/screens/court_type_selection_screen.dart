import 'package:flutter/material.dart';
import '../common/app_bar.dart';
import 'club_selection_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import 'time_selection_screen.dart';

class CourtTypeSelectionScreen extends StatelessWidget {
  final Map<String, dynamic> club;
  final String clubId;
  CourtTypeSelectionScreen({this.club, this.clubId});

  thereIsClubImage() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context, club["name"]),
//          actions: <Widget>[
//            (_clubIsFavorite ? new Icon(Icons.favorite) : new Container())
//          ]),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GroundTypesList(club: club, clubId: clubId),
            thereIsClubImage(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn2',
        onPressed: () {
          Navigator.pop(context);
//          backToClubSelectionPage,
        },
        child: new Icon(Icons.arrow_back_ios),
      ),
    );
  }
}

class GroundTypesList extends StatelessWidget {
  final Map<String, dynamic> club;
  final String clubId;

  GroundTypesList({this.club, this.clubId});

  @override
  Widget build(BuildContext context) {
    List groundTypes;
    String groundTypeId;

    return BlocBuilder<GroundTypesListBloc, GroundTypesListState>(
      builder: (context, state) {
        if (state is GroundTypesListEmpty) {
          BlocProvider.of<GroundTypesListBloc>(context)
              .add(FetchGroundTypesList(clubId: clubId));
        }
        if (state is GroundTypesListError) {
          return Center(
            child: Text('Failed to fetch ground types list'),
          );
        }
        if (state is GroundTypesListLoaded) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.groundTypesList.groundTypesList == null
                  ? 0
                  : state.groundTypesList.groundTypesList.length,
              itemBuilder: (BuildContext context, i) {
//                print(state.groundTypesList);
                groundTypes = state.groundTypesList.groundTypesList;
                groundTypeId = groundTypes[i]["id"];
                return SingleChildScrollView(
                  child: Hero(
                    tag: 'groundTag$i',
                    child: ListTile(
                      title: Text(
                          state.groundTypesList.groundTypesList[i]["name"]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TimeSelectionScreen(
                              club: club,
//                              clubId: clubId,
//                              groundTypeId: groundTypeId,
                            ),
                          ),
                        );
                      },
//                        onTappedGroundType(dataRequestGetGroundTypes[i]
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
//          return new Container();
        }
      },
    );
  }
}