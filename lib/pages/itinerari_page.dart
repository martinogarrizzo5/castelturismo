import 'package:castelturismo/components/base_app_bar.dart';
import 'package:castelturismo/components/download_error_widget.dart';
import 'package:castelturismo/utils/download.dart';
import 'package:castelturismo/models/itinerario.dart';
import 'package:castelturismo/utils/text.dart';
import "package:flutter/material.dart";

class ItinerariPage extends StatefulWidget {
  const ItinerariPage({Key? key}) : super(key: key);

  @override
  State<ItinerariPage> createState() => _CreditsPageState();
}

class _CreditsPageState extends State<ItinerariPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: baseAppBar(context, title: "ITINERARI"),
      body: FutureBuilder(
        future: Download.getPercorsi(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.hasError) {
              return const DownloadErrorWidget();
            } else {
              List<Itinerario> percorsi = dataSnapshot.data as List<Itinerario>;
              return ListView(
                padding: const EdgeInsets.all(24.0),
                children: percorsi
                    .map(
                      (percorso) => ElevatedButton(
                        onPressed: () => Navigator.of(context).pushNamed(
                          "/itinerario",
                          arguments: percorso,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF353538),
                          onPrimary: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Text(
                            TextUtils.getText(percorso.descrizione, context)),
                      ),
                    )
                    .toList(),
              );
            }
          }
        },
      ),
    );
  }
}
