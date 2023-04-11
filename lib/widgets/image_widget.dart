import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../main_export.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.imageUrl, this.width, this.height, this.fit});
  final String imageUrl;
  final double? width, height;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, s) {
        return _buildLoading();
      },
      errorWidget: (context, s, e) {
        return Container(
          color: Colors.blue,
          child: const Center(
              child: Icon(
            Icons.camera_alt,
            size: 60,
          )),
        );
      },
    );
  }

  Widget _buildLoading() {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 30, 30, 30).withOpacity(.8),
        highlightColor: Colors.blue.withOpacity(.6),
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
