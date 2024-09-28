import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/dimora.dart';

class ServizioPage extends StatelessWidget {
  const ServizioPage({Key? key}) : super(key: key);

  AppBar _buildAppBar(BuildContext context, Dimora dimora) {
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

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    final dimora = arguments["dimora"] as Dimora;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(context, dimora),
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
            style: TextStyle(fontSize: 15),
          ),
          // TODO: PUT HERE THE MAP
        ],
      ),
    );
  }
}
