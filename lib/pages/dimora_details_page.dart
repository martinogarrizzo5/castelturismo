import "package:flutter/material.dart";
import 'package:cached_network_image/cached_network_image.dart';
import '../components/base_app_bar.dart';
import '../models/dimora.dart';
import '../utils/styles.dart';
import '../utils/text.dart';

class DimoraDetailsPage extends StatelessWidget {
  const DimoraDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Dimora dimora = routeArgs["dimora"];
    DimoraType? dimoraType = routeArgs["type"];

    return Scaffold(
      appBar: baseAppBar(context, title: ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  key: ValueKey(dimora.mainGeneralPhoto),
                  imageUrl: dimora.mainGeneralPhoto,
                  imageBuilder: (ctx, imageProvider) => Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Image(
                      image: imageProvider,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                  placeholder: (ctx, url) => Container(
                    height: 220,
                    width: double.infinity,
                    margin: const EdgeInsets.all(8.0),
                    child: Center(child: const CircularProgressIndicator()),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                dimora.nome,
                style: titleStyle,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    TextUtils.getText(
                        "<it>Zona: </it><en>Zone: </en><es>Zona: </es><de>Zone: </de>",
                        context),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    dimora.zona!,
                    style: descriptionStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    TextUtils.getText(
                        "<it>Tipologia: </it><en>Type: </en><es>Tipología: </es><de>Typologie: </de>",
                        context),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(dimora.tipologia, style: descriptionStyle),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                dimora.description(context),
                style: descriptionStyle,
                textAlign: TextAlign.justify,
              ),
              Align(
                alignment: Alignment.center,
                child: Wrap(
                  children: dimora.generalPhotosPaths
                      .map(
                        ((path) => CachedNetworkImage(
                              key: ValueKey(path),
                              imageUrl: path,
                              imageBuilder: (ctx, imageProvider) => Container(
                                margin: const EdgeInsets.all(8.0),
                                child: Image(image: imageProvider),
                              ),
                              placeholder: (ctx, url) => Container(
                                height: 100,
                                width: 100,
                                margin: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: const CircularProgressIndicator(),
                                ),
                              ),
                            )),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
