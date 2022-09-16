import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../components/base_app_bar.dart';
import '../components/dimora_mini_card.dart';
import '../models/dimora.dart';
import '../providers/favorites.dart';
import '../utils/text.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _CreditsPageState();
}

class _CreditsPageState extends State<FavoritesPage> {
  // useful to compare list with the updated one from the provider
  List<Dimora>? _favoriteDimore;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      // extract id from page arguments
    });
    super.initState();
  }

  bool isMount = false;
  bool areDimoreLoaded = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isMount || !areDimoreLoaded) {
      setupLocalFavorites();

      final dimore = Provider.of<Favorites>(context).places;
      if (dimore != null) {
        areDimoreLoaded = true;
      }
      isMount = true;
    }
  }

  void setupLocalFavorites() {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>?;
    int? idZona;
    if (routeArgs != null && routeArgs["id"] != null) {
      idZona = routeArgs["id"];
    }

    Map<int, String> zone = {
      1: "Corso XXIX Aprile",
      2: "Dentro le mura",
      3: "Piazza Giorgione",
      4: "Borgo Treviso",
    };

    setState(() {
      final dimore = Provider.of<Favorites>(context, listen: false).places;
      _favoriteDimore = dimore;

      // filter favorites if a zona is provided
      if (idZona != null && dimore != null) {
        final filteredDimore =
            dimore.where((element) => element.zona == zone[idZona]).toList();
        _favoriteDimore = filteredDimore;
      }
    });
  }

  Widget _buildBody() {
    // when favorites are loading from sharedPrefs
    if (_favoriteDimore == null) {
      return const Center(child: CircularProgressIndicator());
    }

    List<Dimora> palazzi = [];
    List<Dimora> hotels = [];
    List<Dimora> bar = [];

    for (var dimora in _favoriteDimore!) {
      if (dimora.tipologia == "Albergo") {
        hotels.add(dimora);
      } else if (dimora.tipologia == "Bar") {
        bar.add(dimora);
      } else {
        palazzi.add(dimora);
      }
    }

    if (_favoriteDimore!.isEmpty) {
      return _buildNoFavorites();
    }

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        if (palazzi.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TextUtils.getText(
                  "<it>Palazzi</it><en>Palaces</en><de>Paläste</de>",
                  context,
                ),
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
            onTap: () => Navigator.of(context).pushNamed(
              "/servizio",
              arguments: {
                "dimora": dimora,
                "type": DimoraType.hotel,
              },
            ),
          ),
        ),
        const SizedBox(height: 32),
        if (bar.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TextUtils.getText(
                  "<it>Bar</it><en>Bar</en><de>Stab</de>",
                  context,
                ),
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
        ...bar.map(
          (dimora) => DimoraMiniCard(
            dimora,
            onTap: () => Navigator.of(context).pushNamed(
              "/servizio",
              arguments: {
                "dimora": dimora,
                "type": DimoraType.bar,
              },
            ),
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
              "<it>Nessun preferito aggiunto</it><en>No favorite place added</en><es>No se han añadido favoritos</es><de>Keine Favoriten hinzugefügt</de>",
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
      appBar: baseAppBar(
        context,
        title: TextUtils.getText(
            "<it>PREFERITI</it><en>FAVORITES</en><es>AHORRA</es><de>SPEICHERT</de>",
            context),
      ),
      body: _buildBody(),
    );
  }
}
