// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';

import '../main_export.dart';

class ListNowPlayingWidget extends StatelessWidget {
  const ListNowPlayingWidget({super.key, required this.list, required this.onTap});
  final List<Shows> list;
  final Function(Shows) onTap;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: Sizes.height(context) * .35,
        viewportFraction: 0.5,
      ),
      items: list.map((e) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () => onTap(e),
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
  }
}
