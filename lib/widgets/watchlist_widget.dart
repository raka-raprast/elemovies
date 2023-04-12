// ignore_for_file: prefer_const_constructors

import 'package:emovied/main_export.dart';
import 'package:emovied/models/saved_show.dart';

class WatchlistWidget extends StatelessWidget {
  const WatchlistWidget({super.key, required this.shows, required this.onTap});
  final SavedShows shows;
  final Function(SavedShows) onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(shows),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: .5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: GradientImage(
            imageUrl: shows.backdropPath != null
                ? "https://image.tmdb.org/t/p/w500${shows.backdropPath!}"
                : shows.posterPath != null
                    ? "https://image.tmdb.org/t/p/w500${shows.posterPath!}"
                    : "",
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(shows.title ?? shows.name ?? "", maxLines: 2, style: CustomTextStyle.title2()),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (shows.voteAverage != null && shows.voteAverage != 0)
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text(shows.voteAverage.toString(), maxLines: 1, style: CustomTextStyle.subtitle())
                                ],
                              ),
                            Text(
                                shows.releaseDate != null
                                    ? shows.releaseDate!.substring(0, 4)
                                    : shows.firstAirDate != null
                                        ? shows.firstAirDate!.substring(0, 4)
                                        : "",
                                maxLines: 1,
                                style: CustomTextStyle.subtitle())
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
