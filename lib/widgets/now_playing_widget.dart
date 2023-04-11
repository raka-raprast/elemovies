// ignore_for_file: prefer_const_constructors

import 'package:emovied/main_export.dart';

class NowPlayingWidget extends StatelessWidget {
  const NowPlayingWidget({super.key, this.isMovie = false, required this.onMovieTap, required this.onTVShowTap, required this.buildList});
  final bool isMovie;
  final Function(bool) onMovieTap, onTVShowTap;
  final Widget Function(BuildContext) buildList;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isMovie ? "Now playing" : "Airing today",
                    style: CustomTextStyle.widgetTitle(),
                  ),
                  Text(
                    isMovie ? "Today's Movie for you to enjoy" : "Airing TV show today's choice",
                    style: CustomTextStyle.subtitle(),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => onMovieTap(isMovie),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isMovie ? Colors.blue : Colors.transparent,
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Movie",
                        style: TextStyle(color: !isMovie ? Colors.blue : Colors.white, fontSize: 14, fontWeight: !isMovie ? null : FontWeight.bold),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onTVShowTap(isMovie),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: !isMovie ? Colors.blue : Colors.transparent,
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        "TV Show",
                        style: TextStyle(color: isMovie ? Colors.blue : Colors.white, fontSize: 14, fontWeight: isMovie ? null : FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
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
