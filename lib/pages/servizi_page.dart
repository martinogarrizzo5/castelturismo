import 'package:castelturismo/components/base_app_bar.dart';
import 'package:castelturismo/components/dimora_mini_card.dart';
import 'package:castelturismo/models/dimora.dart';
import 'package:flutter/material.dart';

class ServiziPage extends StatelessWidget {
  const ServiziPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    List<Dimora> dimore = routeArgs["dimore"] as List<Dimora>? ?? [];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: baseAppBar(context, title: routeArgs["title"]),
      body: ListView(
        children: dimore
            .map(
              (dimora) => DimoraMiniCard(dimora, onTap: () {}),
            )
            .toList(),
      ),
    );
  }
}
