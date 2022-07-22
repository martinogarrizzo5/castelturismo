import 'package:cached_network_image/cached_network_image.dart';
import 'package:castelturismo/components/base_app_bar.dart';
import 'package:castelturismo/models/dimora.dart';
import 'package:castelturismo/utils/styles.dart';
import 'package:castelturismo/utils/text.dart';
import "package:flutter/material.dart";

class DimoraDetailsPage extends StatelessWidget {
  const DimoraDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Dimora dimora = routeArgs["dimora"];
    DimoraType? dimoraType = routeArgs["type"];

    return Scaffold(
      backgroundColor: Colors.black,
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
                    margin: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                dimora.nome,
                style: titleStyle,
              ),
              const SizedBox(height: 16),
              Row(children: [
                Text(
                  TextUtils.getText("<it>Zona: </it><en>Zone: </en>", context),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(dimora.zona!),
              ]),
              Row(children: [
                Text(
                  TextUtils.getText(
                      "<it>Tipologia: </it><en>Type: </en>", context),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(dimora.tipologia),
              ]),
              const SizedBox(height: 8),
              Text(dimora.description(context)),
              Align(
                alignment: Alignment.center,
                child: Wrap(
                  children: dimora.generalPhotosPaths
                      .map(
                        ((path) => CachedNetworkImage(
                              imageUrl: path,
                              imageBuilder: (ctx, imageProvider) => Container(
                                margin: const EdgeInsets.all(8.0),
                                child: Image(image: imageProvider),
                              ),
                              placeholder: (ctx, url) => Container(
                                margin: const EdgeInsets.all(8.0),
                                child: const CircularProgressIndicator(),
                              ),
                            )),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
