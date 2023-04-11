// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:emovied/main_export.dart';

class ArtistDetailScreen extends StatelessWidget {
  const ArtistDetailScreen({super.key, required this.artist});
  final MultiSearch artist;
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
                  imageUrl: artist.profilePath != null
                      ? "https://image.tmdb.org/t/p/w500${artist.profilePath!}"
                      : artist.backdropPath != null
                          ? "https://image.tmdb.org/t/p/w500${artist.backdropPath!}"
                          : artist.posterPath != null
                              ? "https://image.tmdb.org/t/p/w500${artist.posterPath!}"
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
                      artist.title ?? artist.name ?? "",
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
                          artist.popularity.toString(),
                          textAlign: TextAlign.justify,
                          style: CustomTextStyle.title(),
                        ),
                      ],
                    ),
                    Text(
                      artist.releaseDate != null
                          ? artist.releaseDate!
                          : artist.firstAirDate != null
                              ? artist.firstAirDate!
                              : "",
                      textAlign: TextAlign.justify,
                      style: CustomTextStyle.title(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  artist.overview ?? "",
                  textAlign: TextAlign.justify,
                  style: CustomTextStyle.subtitle(),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
