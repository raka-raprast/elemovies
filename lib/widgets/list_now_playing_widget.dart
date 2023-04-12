// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:emovied/blocs/watchlist_bloc.dart';
import 'package:emovied/models/saved_show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main_export.dart';

class ListNowPlayingWidget extends StatelessWidget {
  const ListNowPlayingWidget({super.key, required this.list, required this.onTap});
  final List<Shows> list;
  final Function(Shows) onTap;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistBloc>(create: (_) => WatchlistBloc()..add(WatchlistGetListIDEvent())),
      ],
      child: CarouselSlider(
        options: CarouselOptions(
          height: Sizes.height(context) * .35,
          viewportFraction: 0.5,
        ),
        items: list.map((e) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () => onTap(e),
                child: GradientImage(
                  imageUrl: e.backdropPath != null
                      ? "https://image.tmdb.org/t/p/w500${e.backdropPath!}"
                      : e.posterPath != null
                          ? "https://image.tmdb.org/t/p/w500${e.posterPath!}"
                          : "",
                  stops: const [0, 0.95],
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (e.adult != null && e.adult!)
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "18+",
                                style: TextStyle(color: Colors.pink, fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                          Container(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(e.title ?? e.name ?? "", maxLines: 2, style: CustomTextStyle.title()),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                e.overview!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                                style: CustomTextStyle.subtitle(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    BlocConsumer<WatchlistBloc, WatchlistState>(listener: (context, state) {
                      if (state is WatchlistChangeState) {
                        BlocProvider.of<WatchlistBloc>(context).add(WatchlistGetListIDEvent());
                      }
                    }, builder: (context, state) {
                      return Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            decoration: BoxDecoration(color: Colors.black.withOpacity(.7), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15))),
                            child: IconButton(
                              onPressed: () {
                                if (state is WatchlistLoadedIDState && !state.savedShowResponse.registeredID.contains(e.id)) {
                                  BlocProvider.of<WatchlistBloc>(context).add(
                                    WatchlistAddToWatchListEvent(
                                      SavedShows(
                                        id: e.id,
                                        name: e.name,
                                        originalLanguage: e.originalLanguage,
                                        originalName: e.originalName,
                                        title: e.title,
                                        originalTitle: e.originalTitle,
                                        backdropPath: e.backdropPath,
                                        popularity: e.popularity,
                                        posterPath: e.posterPath,
                                        voteAverage: e.voteAverage,
                                        firstAirDate: e.firstAirDate,
                                        releaseDate: e.releaseDate,
                                        overview: e.overview,
                                      ),
                                    ),
                                  );
                                }
                                if (state is WatchlistLoadedIDState && state.savedShowResponse.registeredID.contains(e.id)) {
                                  BlocProvider.of<WatchlistBloc>(context).add(
                                    WatchlistRemoveFromWatchListEvent(
                                      SavedShows(
                                        id: e.id,
                                        name: e.name,
                                        originalLanguage: e.originalLanguage,
                                        originalName: e.originalName,
                                        title: e.title,
                                        originalTitle: e.originalTitle,
                                        backdropPath: e.backdropPath,
                                        popularity: e.popularity,
                                        posterPath: e.posterPath,
                                        voteAverage: e.voteAverage,
                                        firstAirDate: e.firstAirDate,
                                        releaseDate: e.releaseDate,
                                        overview: e.overview,
                                      ),
                                    ),
                                  );
                                }
                              },
                              iconSize: 30,
                              icon: Icon(
                                state is WatchlistLoadedIDState && state.savedShowResponse.registeredID.contains(e.id) ? Icons.bookmark : Icons.bookmark_outline,
                                color: Colors.blue,
                              ),
                            ),
                          ));
                    }),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
