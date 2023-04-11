// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emovied/main_export.dart';

class ShowSearchDetailScreen extends StatelessWidget {
  const ShowSearchDetailScreen({super.key, required this.shows});
  final MultiSearch shows;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(99), color: Colors.black),
                      child: BackButton(
                        color: Colors.blue,
                      )),
                )
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
    );
  }
}
