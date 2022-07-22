import 'package:castelturismo/components/base_app_bar.dart';
import 'package:castelturismo/components/dimora_mini_card.dart';
import 'package:castelturismo/components/download_error_widget.dart';
import 'package:castelturismo/models/itinerario.dart';
import 'package:castelturismo/models/percorso.dart';
import 'package:castelturismo/utils/download.dart';
import 'package:castelturismo/utils/text.dart';
import 'package:flutter/material.dart';

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
                Image.asset(
                  "assets/sample-dimora.jpg",
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
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
