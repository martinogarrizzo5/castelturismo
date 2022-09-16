import 'package:cached_network_image/cached_network_image.dart';
import 'package:castelturismo/utils/text.dart';

import "package:flutter/material.dart";

class ZonaCard extends StatelessWidget {
  final String imageUrl;
  final void Function() onPress;

  const ZonaCard({
    required this.imageUrl,
    required this.onPress,
    Key? key,
  }) : super(key: key);

  final String discoverButtonText =
      "<it>Scopri di più</it><en>Discover more</en><es>Más información</es><de>Entdecken Sie mehr</de>";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                key: ValueKey(imageUrl),
                imageUrl: imageUrl,
                imageBuilder: (ctx, imageProvider) => Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (ctx, url) => Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -20),
                child: ElevatedButton(
                  onPressed: onPress,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 25,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/book-open.png",
                        height: 21,
                      ),
                      SizedBox(width: 8),
                      Text(
                        TextUtils.getText(discoverButtonText, context),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
