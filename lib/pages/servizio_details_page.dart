import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/dimora.dart';

class ServizioPage extends StatelessWidget {
  const ServizioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    final dimora = arguments["dimora"] as Dimora;

    AppBar _buildAppBar() {
      return AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          padding: EdgeInsets.zero,
          tooltip: "Back",
          splashRadius: 24,
          icon: Image.asset(
            "assets/iconafrecciaback.png",
            width: 36,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          dimora.nome,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(letterSpacing: 7),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: ListView(
        children: [
          CachedNetworkImage(
            key: ValueKey(dimora.mainGeneralPhoto),
            imageUrl: dimora.mainGeneralPhoto,
            imageBuilder: (ctx, imageProvider) => Container(
              margin: const EdgeInsets.all(8.0),
              child: Image(
                image: imageProvider,
                height: 200,
              ),
            ),
            placeholder: (ctx, url) => Container(
              height: 200,
              child: Center(
                child: const CircularProgressIndicator(),
              ),
            ),
          ),
          Text(
            dimora.description(context),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 18),
          Text(
            "tel:  ${dimora.numero}",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6),
          Text(
            dimora.via,
            textAlign: TextAlign.center,
          ),
          // TODO: PUT HERE THE MAP
          if (dimora.generalPhotosPaths.isNotEmpty)
            CachedNetworkImage(
              key: ValueKey(dimora.generalPhotosPaths[0]),
              imageUrl: dimora.generalPhotosPaths[0],
              imageBuilder: (ctx, imageProvider) => Container(
                margin: const EdgeInsets.all(8.0),
                child: Image(
                  image: imageProvider,
                  height: 200,
                ),
              ),
              placeholder: (ctx, url) => Center(
                child: const CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
