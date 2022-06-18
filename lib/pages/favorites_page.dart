import 'package:castelturismo/components/base_app_bar.dart';
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

  Widget _buildBody() {
    return ListView(
      children: _favoriteDimore
          .map(
            (dimora) => GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushNamed("/intro-dimora", arguments: {"dimora": dimora}),
              child: Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      dimora.coverPath,
                    ),
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.srcOver,
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        tooltip: "Favorite",
                        splashRadius: 24,
                        iconSize: 48,
                        icon: Provider.of<Favorites>(context)
                                .containsPlace(dimora.id)
                            ? Image.asset(
                                "assets/iconapreferitifilled.png",
                                height: 48,
                              )
                            : Image.asset(
                                "assets/iconapreferiti.png",
                                height: 48,
                              ),
                        onPressed: () =>
                            Provider.of<Favorites>(context, listen: false)
                                .togglePlace(dimora),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(dimora.nome),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildNoFavorites() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/iconapreferitifilled.png"),
          Text(
            Testo.getText(
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
      appBar: baseAppBar(context, title: "PREFERITI"),
      body: _favoriteDimore.isNotEmpty ? _buildBody() : _buildNoFavorites(),
    );
  }
}
