import 'package:castelturismo/components/base_app_bar.dart';
import 'package:castelturismo/components/download_error_widget.dart';
import 'package:castelturismo/models/credits.dart';
import 'package:castelturismo/utils/download.dart';
import "package:flutter/material.dart";

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
            credits.insert(
              0,
              Credits(
                id: 2,
                descrizione: "Ovviamente tutto merito di Martin Meneghetti.",
              ),
            );

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
