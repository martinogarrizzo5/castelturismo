import 'package:castelturismo/components/base_app_bar.dart';
import 'package:castelturismo/components/dimora_mini_card.dart';
import 'package:castelturismo/models/dimora.dart';
import 'package:castelturismo/providers/favorites.dart';
import 'package:castelturismo/utils/text.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _CreditsPageState();
}

class _CreditsPageState extends State<FavoritesPage> {
  List<Dimora> _favoriteDimore =
      []; // useful to compare list with the updated one from the provider

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _favoriteDimore = Provider.of<Favorites>(context, listen: false).places;
      });
    });
    super.initState();
  }

  // TODO: divide pages in categories: es. Palazzi, Hotels
  Widget _buildBody() {
    List<Dimora> palazzi = [];
    List<Dimora> hotels = [];

    // TODO: add all types of dimore
    for (var dimora in _favoriteDimore) {
      if (dimora.tipologia == "Albergo") {
        hotels.add(dimora);
      } else {
        palazzi.add(dimora);
      }
    }

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        if (palazzi.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Palazzi",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              Divider(
                color: Colors.white,
                thickness: 2,
              )
            ],
          ),
        ...palazzi.map(
          (dimora) => DimoraMiniCard(
            dimora,
            onTap: () => Navigator.of(context)
                .pushNamed("/intro-dimora", arguments: {"dimora": dimora}),
          ),
        ),
        const SizedBox(height: 32),
        if (hotels.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Hotels",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              Divider(
                color: Colors.white,
                thickness: 2,
              )
            ],
          ),
        ...hotels.map(
          (dimora) => DimoraMiniCard(
            dimora,
            onTap: () => Navigator.of(context)
                .pushNamed("/intro-dimora", arguments: {"dimora": dimora}),
          ),
        ),
      ],
    );
  }

  Widget _buildNoFavorites() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/iconapreferitifilled.png"),
          Text(
            TextUtils.getText(
              "<it>Nessun preferito aggiunto</it><en>No favorite place added</en>",
              context,
            ),
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: baseAppBar(
        context,
        title:
            TextUtils.getText("<it>PREFERITI</it><en>FAVORITES</en>", context),
      ),
      body: _favoriteDimore.isNotEmpty ? _buildBody() : _buildNoFavorites(),
    );
  }
}
