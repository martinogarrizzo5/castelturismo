import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../components/base_app_bar.dart';
import '../components/dimora_mini_card.dart';
import '../components/download_error_widget.dart';
import '../models/itinerario.dart';
import '../models/percorso.dart';
import '../utils/download.dart';
import '../utils/text.dart';

class ItinerarioDetailsPage extends StatelessWidget {
  const ItinerarioDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Itinerario itinerario =
        ModalRoute.of(context)!.settings.arguments as Itinerario;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: baseAppBar(
        context,
        title: TextUtils.getText(itinerario.descrizione, context),
      ),
      body: FutureBuilder(
        future: Download.getPercorso(itinerario.id),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return DownloadErrorWidget();
            }

            Percorso percorso = snapshot.data as Percorso;
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                CachedNetworkImage(
                  key: ValueKey(itinerario.imagePath),
                  imageUrl: itinerario.imagePath,
                  width: double.infinity,
                  placeholder: (ctx, url) => LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        height: constraints.minWidth * 1.333,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
                for (int i = 0; i < percorso.dimore.length; i++)
                  DimoraMiniCard(
                    percorso.dimore[i],
                    onTap: () => Navigator.of(context).pushNamed(
                      "/intro-dimora",
                      arguments: {
                        "dimora": percorso.dimore[i],
                      },
                    ),
                    isFavCard: false,
                    pathNumber: i + 1,
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
