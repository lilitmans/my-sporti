import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../common/app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import 'court_type_selection_screen.dart';
import 'time_selection_screen.dart';
import 'package:provider/provider.dart';
import '../repositories/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';

var _filter;
bool _isInputValueMatch = false;

class ClubSelectionScreen extends StatefulWidget {
  final String value;

  ClubSelectionScreen({this.value});
  @override
  _ClubSelectionScreenState createState() => _ClubSelectionScreenState();
}

class _ClubSelectionScreenState extends State<ClubSelectionScreen> {
  final _myController = TextEditingController();

  @override
  void initState() {
//    print("$re");
    _myController.addListener(_isSearchValueMatch);
    getIds();
    super.initState();

    setState(() {
      _myController.text = widget.value;
    });
  }

  void getIds() async {
    String _clubFavKey;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String thisId = prefs.getString(_clubFavKey);
    print("favorite $thisId");
  }

  _isSearchValueMatch() {
    _filter = _myController.text;
    if (_filter == null || _filter == "" || _filter.length < 4) {
      setState(() {
        _isInputValueMatch = false;
      });
    } else {
      setState(() {
        _isInputValueMatch = true;
      });
    }
  }

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: appBar(context, 'Clubauswahl')),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                autofocus: true,
                controller: _myController,
                decoration: InputDecoration(
                  labelText: "Suche",
                  hintText: "Club-Name oder Adresse (min. 4 Zeichen)",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: ClubsItemList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn1',
        onPressed: () {
          Phoenix.rebirth(context);
        },
        child: new Image.asset('images/logo.png'),
      ),
    );
  }
}

class ClubsItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List clubs;
    final favoriteClub = Provider.of<MarkClubAsFavorite>(context);

    return BlocBuilder<ClubsListBloc, ClubsListState>(
      builder: (context, state) {
        if (state is ClubsListEmpty) {
          favoriteClub.readFavorite();
          print("favoriteClubs: ${favoriteClub.favoriteClubs}");
          BlocProvider.of<ClubsListBloc>(context).add(FetchClubsList());
        }
        if (state is ClubsListError) {
          return Center(
            child: Text('Failed to fetch clubs list'),
          );
        }
        if (state is ClubsListLoaded) {
          favoriteClub.readFavorite();
          return Expanded(
            child: ListView.builder(
              itemCount: state.clubsList.clubs == null
                  ? 0
                  : state.clubsList.clubs.length,
              itemBuilder: (BuildContext context, i) {
                clubs = state.clubsList.clubs;
                String clubId = clubs[i]["id"];
                String clubName = clubs[i]["name"].toLowerCase();
                String clubAddress = clubs[i]["address"].toLowerCase();

                favoriteClub.readFavorite();
                if (_isInputValueMatch == false &&
                    !favoriteClub.isClubFavorite(clubId)) {
                  return new Container();
                } else if (clubName.contains(_filter.toLowerCase()) ||
                    clubAddress.contains(_filter.toLowerCase()) ||
                    favoriteClub.isClubFavorite(clubId)) {
                  return SingleChildScrollView(
                    child: Hero(
                      tag: 'clubTag$i',
                      child: ListTile(
                        title: Text(clubs[i]["name"]),
                        subtitle: Text(clubs[i]["address"]),
                        leading: IconButton(
                          icon: favoriteClub.isClubFavorite(clubId)
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_border),
                          onPressed: () {
                            favoriteClub.markClubAsFavorite(clubId);
                            favoriteClub.readFavorite();
                          },
                        ),
                        trailing: Icon(clubs[i]["allow_booking"] == "1"
                            ? Icons.attach_money
                            : Icons.person),
                        onTap: () {
                          if (clubs[i]["cnt_ground_type"] == "1") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TimeSelectionScreen(
                                  club: clubs[i],
                                  groundName: clubs[i]
                                      ["ground_type__description"],
                                  groundTypeId: clubs[i]['id'],
                                  filter: _filter,
                                ),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CourtTypeSelectionScreen(
                                  club: clubs[i],
                                  clubId: clubId,
                                  filter: _filter,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  );
                } else {
                  return new Container();
                }
              },
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
