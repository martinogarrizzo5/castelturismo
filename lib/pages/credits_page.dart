import "package:flutter/material.dart";
import '../components/base_app_bar.dart';
import '../components/download_error_widget.dart';
import '../models/credits.dart';
import '../utils/download.dart';

class CreditsPage extends StatefulWidget {
  const CreditsPage({Key? key}) : super(key: key);

  @override
  State<CreditsPage> createState() => _CreditsPageState();
}

class _CreditsPageState extends State<CreditsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: baseAppBar(context, title: "CREDITS"),
      body: FutureBuilder(
        future: Download.getCredits(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.hasError) {
              return DownloadErrorWidget();
            }
            var credits = dataSnapshot.data as List<Credits>;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: credits
                  .map(
                    (e) => Text(e.descrizione),
                  )
                  .toList(),
            );
          }
        },
      ),
    );
  }
}
