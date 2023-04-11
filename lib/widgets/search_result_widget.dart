// ignore_for_file: prefer_const_constructors

import 'package:emovied/main_export.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key, required this.multiSearch, required this.onTap});
  final MultiSearch multiSearch;
  final Function(MultiSearch) onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(multiSearch),
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
                imageUrl: multiSearch.backdropPath != null
                    ? "https://image.tmdb.org/t/p/w500${multiSearch.backdropPath!}"
                    : multiSearch.posterPath != null
                        ? "https://image.tmdb.org/t/p/w500${multiSearch.posterPath!}"
                        : multiSearch.profilePath != null
                            ? "https://image.tmdb.org/t/p/w500${multiSearch.profilePath!}"
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
                    if (multiSearch.adult != null && multiSearch.adult!)
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
                        Text(multiSearch.title ?? multiSearch.name ?? "", maxLines: 2, style: CustomTextStyle.title2()),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (multiSearch.voteAverage != null && multiSearch.voteAverage != 0)
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text(multiSearch.voteAverage.toString(), maxLines: 1, style: CustomTextStyle.subtitle())
                                ],
                              ),
                            Text(
                                multiSearch.releaseDate != null
                                    ? multiSearch.releaseDate!.substring(0, 4)
                                    : multiSearch.firstAirDate != null
                                        ? multiSearch.firstAirDate!.substring(0, 4)
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
  }
}
