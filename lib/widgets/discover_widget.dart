// ignore_for_file: prefer_const_constructors

import 'package:emovied/main_export.dart';

enum DiscoverChip {
  popularMovies,
  topRatedMovies,
  popularTVShow,
  topRatedTVShow,
}

class DiscoverWidget extends StatelessWidget {
  const DiscoverWidget({super.key, required this.onPopularMoviesTap, required this.onTopRatedMoviesTap, required this.onPopularTVShowsTap, required this.onTopRatedTVShowsTap, required this.discoverChip, required this.buildList});
  final Function(DiscoverChip) onPopularMoviesTap, onTopRatedMoviesTap, onPopularTVShowsTap, onTopRatedTVShowsTap;
  final DiscoverChip discoverChip;
  final Widget Function(BuildContext) buildList;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Discover",
            style: CustomTextStyle.widgetTitle(),
          ),
        ),
        SizedBox(
          height: Sizes.height(context) * .05,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              FilterButton(
                onTap: () => onPopularMoviesTap(DiscoverChip.popularMovies),
                child: FilterText(
                  isSelected: discoverChip == DiscoverChip.popularMovies,
                  text: "Popular Movies",
                ),
              ),
              FilterButton(
                onTap: () => onTopRatedMoviesTap(DiscoverChip.topRatedMovies),
                child: FilterText(
                  isSelected: discoverChip == DiscoverChip.topRatedMovies,
                  text: "Top Rated Movies",
                ),
              ),
              FilterButton(
                onTap: () => onPopularTVShowsTap(DiscoverChip.popularTVShow),
                child: FilterText(
                  isSelected: discoverChip == DiscoverChip.popularTVShow,
                  text: "Popular TV Show",
                ),
              ),
              FilterButton(
                onTap: () => onTopRatedTVShowsTap(DiscoverChip.topRatedTVShow),
                child: FilterText(
                  isSelected: discoverChip == DiscoverChip.topRatedTVShow,
                  text: "Top Rated TV Show",
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        buildList(context),
      ],
    );
  }
}
