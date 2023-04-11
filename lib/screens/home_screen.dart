// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../main_export.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMovie = true;
  DiscoverChip discoverChip = DiscoverChip.popularMovies;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UpcomingBloc>(
          create: (_) => UpcomingBloc()..add(UpcomingGetListEvent()),
        ),
        BlocProvider<NowPlayingBloc>(
          create: (_) => NowPlayingBloc()..add(NowPlayingInitMovieEvent()),
        ),
        BlocProvider<DiscoverBloc>(
          create: (_) => DiscoverBloc()..add(DiscoverInitMovieEvent()),
        )
      ],
      child: ListView(
        children: [
          BlocBuilder<UpcomingBloc, UpcomingState>(builder: (context, state) {
            if (state is UpcomingLoadedState) {
              return CarouselSlider(
                options: CarouselOptions(
                  height: Sizes.height(context) * .35,
                  viewportFraction: 1,
                ),
                items: state.trendingResponse.map((e) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShowDetailScreen(shows: e)));
                        },
                        child: Stack(
                          children: [
                            ImageWidget(
                              imageUrl: e.backdropPath != null
                                  ? "https://image.tmdb.org/t/p/w500${e.backdropPath!}"
                                  : e.posterPath != null
                                      ? "https://image.tmdb.org/t/p/w500${e.posterPath!}"
                                      : "",
                              width: Sizes.width(context),
                              height: Sizes.height(context) * .35,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: Sizes.height(context) * .175,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  gradient: LinearGradient(begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter, colors: [
                                    Colors.black.withOpacity(0.0),
                                    Colors.black,
                                  ], stops: const [
                                    0.0,
                                    0.95,
                                  ]),
                                ),
                              ),
                            ),
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
                            )
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              );
            } else if (state is UpcomingErrorState) {
              return Text(
                "Error please try again later",
                style: TextStyle(color: Colors.red),
              );
            } else if (state is UpcomingLoadingState) {
              return SizedBox(
                width: Sizes.width(context),
                height: Sizes.height(context) * .35,
                child: Shimmer.fromColors(
                  baseColor: const Color.fromARGB(255, 30, 30, 30).withOpacity(.8),
                  highlightColor: Colors.blue.withOpacity(.6),
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              );
            }
            return Container();
          }),
          SizedBox(
            height: 15,
          ),
          BlocBuilder<NowPlayingBloc, NowPlayingState>(builder: (context, state) {
            return NowPlayingWidget(
              buildList: (context) {
                if (state is NowPlayingLoadingState) {
                  return CarouselSlider(
                    options: CarouselOptions(
                      height: Sizes.height(context) * .35,
                      viewportFraction: 0.5,
                    ),
                    items: [
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.blue, width: .5)),
                        width: Sizes.width(context),
                        height: Sizes.height(context) * .35,
                        child: Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 30, 30, 30).withOpacity(.8),
                          highlightColor: Colors.blue.withOpacity(.6),
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is NowPlayingErrorState) {
                  return Text(
                    "Error please try again later",
                    style: TextStyle(color: Colors.red),
                  );
                }
                return ListNowPlayingWidget(
                  list: state is NowPlayingLoadedMovieState
                      ? state.nowPlayingResponse
                      : state is NowPlayingLoadedTVShowState
                          ? state.nowPlayingResponse
                          : [],
                  onTap: (shows) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowDetailScreen(shows: shows)));
                  },
                );
              },
              onMovieTap: (b) {
                setState(() {
                  isMovie = true;
                });
                BlocProvider.of<NowPlayingBloc>(context).add(NowPlayingGetMovieEvent());
              },
              onTVShowTap: (b) {
                setState(() {
                  isMovie = false;
                });
                BlocProvider.of<NowPlayingBloc>(context).add(NowPlayingGetTVShowEvent());
              },
              isMovie: isMovie,
            );
          }),
          SizedBox(
            height: 15,
          ),
          Divider(
            color: Colors.blue.withOpacity(.5),
          ),
          SizedBox(
            height: 10,
          ),
          BlocBuilder<DiscoverBloc, DiscoverState>(builder: (context, state) {
            return DiscoverWidget(
                onPopularMoviesTap: (dc) {
                  BlocProvider.of<DiscoverBloc>(context).add(DiscoverGetPopularMovieEvent());
                  setState(() {
                    discoverChip = dc;
                  });
                },
                onTopRatedMoviesTap: (dc) {
                  BlocProvider.of<DiscoverBloc>(context).add(DiscoverGetTopRatedMovieEvent());
                  setState(() {
                    discoverChip = dc;
                  });
                },
                onPopularTVShowsTap: (dc) {
                  BlocProvider.of<DiscoverBloc>(context).add(DiscoverGetPopularTVShowEvent());
                  setState(() {
                    discoverChip = dc;
                  });
                },
                onTopRatedTVShowsTap: (dc) {
                  BlocProvider.of<DiscoverBloc>(context).add(DiscoverGetTopRatedTVShowEvent());
                  setState(() {
                    discoverChip = dc;
                  });
                },
                discoverChip: discoverChip,
                buildList: (context) {
                  if (state is DiscoverLoadingState) {
                    return CircularProgressIndicator();
                  } else if (state is DiscoverErrorState) {
                    return Text(
                      "Error please try again later",
                      style: TextStyle(color: Colors.red),
                    );
                  }
                  return ListDiscoverWidget(
                    list: _getDiscoverList(state),
                    onTap: (shows) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowDetailScreen(shows: shows)));
                    },
                  );
                });
          }),
          SizedBox(
            height: Sizes.height(context) * .05,
          ),
        ],
      ),
    );
  }

  List<Shows> _getDiscoverList(DiscoverState state) {
    if (state is DiscoverLoadedPopularMovieState) {
      return state.discoverResponse;
    } else if (state is DiscoverLoadedPopularTVShowState) {
      return state.discoverResponse;
    } else if (state is DiscoverLoadedTopRatedMovieState) {
      return state.discoverResponse;
    } else if (state is DiscoverLoadedTopRatedTVShowState) {
      return state.discoverResponse;
    }
    return [];
  }
}
