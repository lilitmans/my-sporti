import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'screens/splash_screen.dart';
import 'common/theme.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';
import 'repositories/clubs_list_api_client.dart';
import 'repositories/repositories.dart';
import 'package:provider/provider.dart';
import 'repositories/mark_club_as_favorite.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
//    print(transition);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final ClubsListRepository clubsListRepository = ClubsListRepository(
    clubsListApiClient: ClubsListApiClient(
      httpClient: http.Client(),
    ),
  );

  final GroundTypesListRepository groundTypesListRepository =
      GroundTypesListRepository(
    clubsListApiClient: ClubsListApiClient(
      httpClient: http.Client(),
    ),
  );

  final ReservationTimeListRepository reservationTimeListRepository =
      ReservationTimeListRepository(
    clubsListApiClient: ClubsListApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(
    Phoenix(
      child: Application(
        clubsListRepository: clubsListRepository,
        groundTypesListRepository: groundTypesListRepository,
        reservationTimeListRepository: reservationTimeListRepository,
      ),
    ),
  );
}

class Application extends StatelessWidget {
  final ClubsListRepository clubsListRepository;
  final GroundTypesListRepository groundTypesListRepository;
  final ReservationTimeListRepository reservationTimeListRepository;

  Application({
    Key key,
    @required this.clubsListRepository,
    @required this.groundTypesListRepository,
    @required this.reservationTimeListRepository,
  })  : assert(
          clubsListRepository != null,
          groundTypesListRepository != null,
//  reservationTimeListRepository != null,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = 'My Sporti';
    return MultiProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                ClubsListBloc(clubsListRepository: clubsListRepository)),
        BlocProvider(
            create: (context) => GroundTypesListBloc(
                groundTypesListRepository: groundTypesListRepository)),
        BlocProvider(
            create: (context) => ReservationTimeListBloc(
                reservationTimeListRepository: reservationTimeListRepository)),
        ChangeNotifierProvider(create: (context) => MarkClubAsFavorite()),
      ],
      child: MaterialApp(
        title: title,
        theme: appTheme,
        home: Container(
          child: SplashScreen(),
        ),
      ),
    );
  }
}
