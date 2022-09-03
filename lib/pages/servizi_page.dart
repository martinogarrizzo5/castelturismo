import 'package:flutter/material.dart';
import '../components/base_app_bar.dart';
import '../components/dimora_mini_card.dart';
import '../components/no_dimora.dart';
import '../models/dimora.dart';
import '../utils/text.dart';

class ServiziPage extends StatelessWidget {
  const ServiziPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    List<Dimora> dimore = routeArgs["dimore"] as List<Dimora>? ?? [];
    String title = routeArgs["title"];

    Widget _buildBody(List<Dimora> dimore) {
      return ListView(
        padding: const EdgeInsets.all(16),
        children: dimore
            .map(
              (dimora) => DimoraMiniCard(
                dimora,
                onTap: () => Navigator.of(context).pushNamed(
                  "/servizio",
                  arguments: {"dimora": dimora},
                ),
              ),
            )
            .toList(),
      );
    }

    Widget _buildNoDimora() {
      return NoDimora(
        text: TextUtils.getText(
          "<it>Nessun $title trovato</it><en>No $title found</en><es>No se han encontrado $title</es><de>Keine $title gefunden</de>",
          context,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: baseAppBar(context, title: routeArgs["title"]),
      body: dimore.isEmpty ? _buildNoDimora() : _buildBody(dimore),
    );
  }
}
