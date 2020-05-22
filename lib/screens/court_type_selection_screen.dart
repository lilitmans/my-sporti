import 'package:flutter/material.dart';
import '../common/app_bar.dart';
import 'club_selection_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import 'time_selection_screen.dart';
import '../repositories/repositories.dart';

class CourtTypeSelectionScreen extends StatefulWidget {
  final Map<String, dynamic> club;
  final String clubId;
  final String filter;

  CourtTypeSelectionScreen({this.club, this.clubId, this.filter});

  @override
  _CourtTypeSelectionScreenState createState() => _CourtTypeSelectionScreenState();
}

class _CourtTypeSelectionScreenState extends State<CourtTypeSelectionScreen> {
  MarkClubAsFavorite markClubAsFavorite = MarkClubAsFavorite();
  bool _clubIsFav = false;

  @override

  void initState() {
    print("_clubIsFav ${markClubAsFavorite.clubIsFav}");
    markClubAsFavorite.markClubAsFavorite(this.widget.club["id"]);
    _clubIsFav = markClubAsFavorite.clubIsFav;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: appBar(context, this.widget.club["name"]), actions: <Widget>[
        (_clubIsFav ? new Icon(Icons.favorite) : new Container())
      ],),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GroundTypesList(club: this.widget.club, clubId: this.widget.club["id"]),
            thereIsClubImage(this.widget.club),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn2',
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => ClubSelectionScreen(value: this.widget.filter,)),
                  (Route<dynamic> route) => true);
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
                                groundName: state
                                    .groundTypesList.groundTypesList[i]["name"]
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
