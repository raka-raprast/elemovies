// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';

import '../main_export.dart';

class ListDiscoverWidget extends StatelessWidget {
  const ListDiscoverWidget({super.key, required this.list, required this.onTap});
  final List<Shows> list;
  final Function(Shows) onTap;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: Sizes.height(context) * .35,
        viewportFraction: 0.5,
        pageSnapping: false,
      ),
      items: list.map((e) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () => onTap(e),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: .5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
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
                              0.8,
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
                                Text(e.title ?? e.name ?? "", maxLines: 2, style: CustomTextStyle.title2()),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        Text(e.voteAverage.toString(), maxLines: 1, style: CustomTextStyle.subtitle())
                                      ],
                                    ),
                                    Text(
                                        e.releaseDate != null
                                            ? e.releaseDate!.substring(0, 4)
                                            : e.firstAirDate != null
                                                ? e.firstAirDate!.substring(0, 4)
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
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
