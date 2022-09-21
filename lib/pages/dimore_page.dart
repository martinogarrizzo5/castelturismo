import 'package:castelturismo/providers/favorites.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/no_dimora.dart';
import '../providers/filters.dart';
import '../utils/download.dart';
import '../utils/styles.dart';
import '../utils/text.dart';
import "../components/dimora_big_card.dart";
import '../models/dimora.dart';
import '../models/zona.dart';

class DimorePage extends StatefulWidget {
  const DimorePage({Key? key}) : super(key: key);

  @override
  State<DimorePage> createState() => _DimorePageState();
}

class _DimorePageState extends State<DimorePage> {
  PageController _pageController = PageController();
  Zona? _zona;
  late int idZona;
  List<Dimora> _dimore = [];
  bool _isLoading = false;
  double currentPage = 0;

  void controlPages() {
    setState(() {
      currentPage = _pageController.page!;
    });
  }

  @override
  void initState() {
    _pageController.addListener(controlPages);

    // fetch dimore based on id
    Future.delayed(Duration.zero).then(
      (_) async {
        setState(() => _isLoading = true);
        final routeArgs =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

        final filters =
            Provider.of<Filters>(context, listen: false).formattedFiltersId;

        idZona = routeArgs["id"];

        if (filters.isEmpty) {
          final zona = await Download.getDimore(idZona: idZona);

          setState(() {
            _zona = zona;
            _dimore = zona.monumenti;
            _isLoading = false;
          });
        } else {
          final dimore = await Download.getFilteredDimore(
              idZona: idZona, filters: filters);
          final palaces = dimore
              .where((dimora) =>
                  dimora.tipologia != "Albergo" && dimora.tipologia != "Bar")
              .toList();

          setState(() {
            _dimore = palaces;
            _isLoading = false;
          });
        }
      },
    );

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // TODO: POSSIBLE TO CALL HERE THE API WHEN FILTERS CHANGE
    // bool isMounted  bool areFiltersChanged
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.removeListener(controlPages);
  }

  void goToIntroDimora(Dimora dimora) {
    Navigator.of(context)
        .pushNamed("/intro-dimora", arguments: {"dimora": dimora});
  }

  Widget _pageBody() {
    // prevent access to page if filters and favorites request hasn't completed yet
    final filters = Provider.of<Filters>(context).filters;
    final favorites = Provider.of<Favorites>(context).places;
    if (_isLoading || filters == null || favorites == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (_dimore.isEmpty) {
      return NoDimora(
        text: TextUtils.getText(
          "<it>Nessuna dimora con questi filtri</it><en>No place found with this filters</en><es>No hay vivienda con estos filtros</es><de>Keine Wohnung mit diesen Filtern</de>",
          context,
        ),
        onPressed: () => Navigator.of(context).pushReplacementNamed("/filters"),
      );
    } else {
      return Stack(
        children: [
          PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            children: _dimore
                .map(
                  (dimora) => ZonaCard(
                    imageUrl: dimora.coverPath,
                    onPress: () => goToIntroDimora(dimora),
                  ),
                )
                .toList(),
          ),
          Positioned(
              bottom: 5,
              right: 0,
              left: 0,
              child: DotsIndicator(
                dotsCount: _dimore.length,
                position: currentPage,
                onTap: (pos) {
                  _pageController.animateToPage(
                    pos.toInt(),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
              ))
        ],
      );
    }
  }

  BottomNavigationBar _buildNavBar() {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        if (index == 0) {
          Navigator.of(context).pushNamed(
            "/servizi",
            arguments: {
              "title": TextUtils.getText(
                "<it>Ristoro\\Bar</it><en>Restaurants\\Bar</en><de>Restaurants\\Stab</de>",
                context,
              ),
              "dimore": _zona?.bar,
            },
          );
        } else if (index == 1) {
          Navigator.of(context).pushNamed(
            "/servizi",
            arguments: {"title": "Hotel", "dimore": _zona?.hotels},
          );
        } else if (index == 2) {
          Navigator.of(context).pushNamed(
            "/favorites",
            arguments: {"id": idZona},
          );
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Image.asset("assets/iconabar.png", width: 40, height: 40),
          label: "",
          tooltip: TextUtils.getText(
            "<it>Bar</it><en>Bar</en><de>Stab</de>",
            context,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/iconahotel.png", width: 42, height: 42),
          label: "",
          tooltip: "Hotels",
        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/iconapreferiti.png", width: 48, height: 48),
          label: "",
          tooltip: TextUtils.getText(
            "<it>Preferiti</it><en>Favorites</en><es>Ahorra</es><de>Speichert</de>",
            context,
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String? title = routeArgs["title"];
    final String? titleImagePath = routeArgs["title-image"];

    Widget titleWidget;
    if (title != null) {
      titleWidget = Text(title);
    } else if (titleImagePath != null) {
      titleWidget = Image.asset(titleImagePath, height: 72);
    } else {
      titleWidget = const Text("Dimore", style: titleStyle);
    }

    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        tooltip: "Back",
        splashRadius: 24,
        icon: Image.asset(
          "assets/iconafrecciaback.png",
          width: 36,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: titleWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: _pageBody(),
      bottomNavigationBar: _isLoading ? null : _buildNavBar(),
    );
  }
}
