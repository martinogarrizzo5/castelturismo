import "package:flutter/material.dart";
import '../components/base_app_bar.dart';
import '../components/download_error_widget.dart';
import '../utils/download.dart';
import '../models/intro_percorso.dart';
import '../utils/text.dart';

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
      appBar: baseAppBar(
        context,
        title: TextUtils.getText(
          "<it>ITINERARI</it><en>ROUTES</en><de>ROUTEN</de>",
          context,
        ),
      ),
      body: FutureBuilder(
        future: Download.getPercorsi(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.hasError) {
              return const DownloadErrorWidget();
            } else {
              List<IntroPercorso> percorsi =
                  dataSnapshot.data as List<IntroPercorso>;
              return ListView.separated(
                padding: const EdgeInsets.all(24.0),
                itemCount: percorsi.length,
                itemBuilder: (ctx, i) => ElevatedButton(
                  onPressed: () => Navigator.of(context).pushNamed(
                    "/itinerario",
                    arguments: percorsi[i],
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
                    TextUtils.getText(percorsi[i].descrizione, context),
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                separatorBuilder: (ctx, i) => const SizedBox(height: 28),
              );
            }
          }
        },
      ),
    );
  }
}
