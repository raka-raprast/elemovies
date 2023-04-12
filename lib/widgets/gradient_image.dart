// ignore_for_file: prefer_const_constructors

import 'package:emovied/main_export.dart';

class GradientImage extends StatelessWidget {
  const GradientImage({super.key, required this.imageUrl, this.children, this.colors, this.stops, this.imageHeight, this.imageWidth, this.gradientHeight, this.gradientWidth});
  final String imageUrl;
  final List<Widget>? children;
  final List<Color>? colors;
  final List<double>? stops;
  final double? imageHeight, imageWidth, gradientHeight, gradientWidth;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageWidget(
          imageUrl: imageUrl,
          width: imageWidth ?? Sizes.width(context),
          height: imageHeight ?? Sizes.height(context) * .35,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: gradientHeight ?? Sizes.height(context) * .175,
            width: gradientWidth,
            decoration: BoxDecoration(
              color: Colors.black,
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: colors ??
                      [
                        Colors.black.withOpacity(0.0),
                        Colors.black,
                      ],
                  stops: stops ??
                      [
                        0.0,
                        0.8,
                      ]),
            ),
          ),
        ),
        if (children != null) ...children!
      ],
    );
  }
}
