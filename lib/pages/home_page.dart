import 'package:castelturismo/providers/favorites.dart';
import 'package:castelturismo/providers/filters.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // FETCH FAVORITES AND FILTERS
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Filters>(context, listen: false).loadFilters();
      Provider.of<Favorites>(context, listen: false).loadFavorites();
    });
    super.initState();
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.black,
      title: Column(
        children: const [
          Text(
            "castelfranco",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              letterSpacing: 3,
              fontSize: 17,
            ),
          ),
          Text(
            "VENETO",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 9,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          splashRadius: 24,
          iconSize: 64,
          icon: Image.asset("assets/iconapreferiti.png"),
          onPressed: () => Navigator.of(context).pushNamed("/favorites"),
        ),
      ],
    );
  }

  void _onBottomAppBarTap(int itemIndex) {
    if (itemIndex == 0) {
      Navigator.of(context).pushNamed("/filters");
    } else if (itemIndex == 1) {
      Navigator.of(context).pushNamed("/itinerari");
    } else if (itemIndex == 2) {
      Navigator.of(context).pushNamed("/credits");
    }
  }

  BottomNavigationBar _buildNavBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: _onBottomAppBarTap,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset("assets/iconacerca.png", width: 64, height: 64),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/iconaorologio.png", width: 42, height: 42),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/iconainfo.png", width: 64, height: 64),
          label: "",
        ),
      ],
    );
  }

  Widget _buildHomeSection(int id, {String? imagePath}) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(),
          onTap: () => Navigator.of(context).pushNamed(
            "/dimore",
            arguments: {
              'id': id,
              "title-image": imagePath,
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(children: [
          Positioned.fill(
            child: Align(
              child: Image.asset(
                "assets/home.png",
                alignment: Alignment.center,
                scale: 1.2,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHomeSection(
                      1,
                      imagePath: "assets/iconapiazzagiorgione.png",
                    ),
                    _buildHomeSection(
                      2,
                      imagePath: "assets/iconaborgotreviso.png",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHomeSection(
                      3,
                      imagePath: "assets/iconatramura.png",
                    ),
                    _buildHomeSection(
                      4,
                      imagePath: "assets/iconacorso29.png",
                    ),
                  ],
                ),
              ),
            ],
          )
        ]),
      ),
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildNavBar(),
    );
  }
}
