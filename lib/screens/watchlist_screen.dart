// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emovied/blocs/watchlist_bloc.dart';
import 'package:emovied/screens/watchlist_detail_screen.dart';
import 'package:emovied/widgets/watchlist_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main_export.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<WatchlistBloc>(create: (_) => WatchlistBloc()..add(WatchlistGetListIDEvent()))],
      child: BlocBuilder<WatchlistBloc, WatchlistState>(builder: (context, state) {
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Text(
                "Watchlist",
                style: CustomTextStyle.widgetTitle(),
              ),
            ),
            if (state is WatchlistLoadedIDState && state.savedShowResponse.shows.isNotEmpty)
              GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: .8,
                crossAxisCount: 2,
                children: state.savedShowResponse.shows
                    .map(
                      (e) => WatchlistWidget(
                        shows: e,
                        onTap: (item) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShowWatchlistDetailScreen(shows: item)));
                        },
                      ),
                    )
                    .toList(),
              ),
            if (state is WatchlistLoadedIDState && state.savedShowResponse.shows.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Start add your favourite movie to your Watchlist",
                    style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(.5)),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
