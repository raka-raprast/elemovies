// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emovied/blocs/watchlist_bloc.dart';
import 'package:emovied/main_export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/saved_show.dart';

class ShowWatchlistDetailScreen extends StatelessWidget {
  const ShowWatchlistDetailScreen({super.key, required this.shows});
  final SavedShows shows;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistBloc>(create: (_) => WatchlistBloc()..add(WatchlistGetListIDEvent())),
      ],
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: ListView(children: [
            SizedBox(
              width: Sizes.width(context),
              height: Sizes.height(context) * .45,
              child: Stack(
                children: [
                  ImageWidget(
                    imageUrl: shows.backdropPath != null
                        ? "https://image.tmdb.org/t/p/w500${shows.backdropPath!}"
                        : shows.posterPath != null
                            ? "https://image.tmdb.org/t/p/w500${shows.posterPath!}"
                            : "",
                    width: Sizes.width(context),
                    height: Sizes.height(context) * .45,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: Sizes.height(context) * .1,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        gradient: LinearGradient(begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter, colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black,
                        ], stops: const [
                          0.0,
                          0.7,
                        ]),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        shows.title ?? shows.name ?? "",
                        maxLines: 2,
                        style: CustomTextStyle.header(),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(99), color: Colors.black),
                            child: BackButton(
                              color: Colors.blue,
                            )),
                        BlocConsumer<WatchlistBloc, WatchlistState>(listener: (context, state) {
                          if (state is WatchlistChangeState) {
                            BlocProvider.of<WatchlistBloc>(context).add(WatchlistGetListIDEvent());
                          }
                        }, builder: (context, state) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.7),
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: IconButton(
                              onPressed: () {
                                if (state is WatchlistLoadedIDState && !state.savedShowResponse.registeredID.contains(shows.id)) {
                                  BlocProvider.of<WatchlistBloc>(context).add(
                                    WatchlistAddToWatchListEvent(
                                      SavedShows(
                                        id: shows.id,
                                        name: shows.name,
                                        originalLanguage: shows.originalLanguage,
                                        originalName: shows.originalName,
                                        title: shows.title,
                                        originalTitle: shows.originalTitle,
                                        backdropPath: shows.backdropPath,
                                        popularity: shows.popularity,
                                        posterPath: shows.posterPath,
                                        voteAverage: shows.voteAverage,
                                        firstAirDate: shows.firstAirDate,
                                        releaseDate: shows.releaseDate,
                                        overview: shows.overview,
                                      ),
                                    ),
                                  );
                                }
                                if (state is WatchlistLoadedIDState && state.savedShowResponse.registeredID.contains(shows.id)) {
                                  BlocProvider.of<WatchlistBloc>(context).add(
                                    WatchlistRemoveFromWatchListEvent(
                                      SavedShows(
                                        id: shows.id,
                                        name: shows.name,
                                        originalLanguage: shows.originalLanguage,
                                        originalName: shows.originalName,
                                        title: shows.title,
                                        originalTitle: shows.originalTitle,
                                        backdropPath: shows.backdropPath,
                                        popularity: shows.popularity,
                                        posterPath: shows.posterPath,
                                        voteAverage: shows.voteAverage,
                                        firstAirDate: shows.firstAirDate,
                                        releaseDate: shows.releaseDate,
                                        overview: shows.overview,
                                      ),
                                    ),
                                  );
                                }
                              },
                              iconSize: 30,
                              icon: Icon(
                                state is WatchlistLoadedIDState && state.savedShowResponse.registeredID.contains(shows.id) ? Icons.bookmark : Icons.bookmark_outline,
                                color: Colors.blue,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text(
                            shows.voteAverage.toString(),
                            textAlign: TextAlign.justify,
                            style: CustomTextStyle.title(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Average Vote",
                            textAlign: TextAlign.justify,
                            style: CustomTextStyle.subtitle(),
                          )
                        ],
                      ),
                      Text(
                        shows.releaseDate != null
                            ? shows.releaseDate!.substring(0, 4)
                            : shows.firstAirDate != null
                                ? shows.firstAirDate!.substring(0, 4)
                                : "",
                        textAlign: TextAlign.justify,
                        style: CustomTextStyle.title(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.blue, width: .5)),
                        child: ImageWidget(
                          imageUrl: shows.posterPath != null
                              ? "https://image.tmdb.org/t/p/w500${shows.posterPath!}"
                              : shows.backdropPath != null
                                  ? "https://image.tmdb.org/t/p/w500${shows.backdropPath!}"
                                  : "",
                          width: Sizes.width(context) * .3,
                          height: Sizes.height(context) * .25,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            shows.overview ?? "",
                            textAlign: TextAlign.justify,
                            style: CustomTextStyle.subtitle(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
