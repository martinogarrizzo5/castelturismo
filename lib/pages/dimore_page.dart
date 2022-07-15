import 'package:castelturismo/providers/filters.dart';
import 'package:castelturismo/utils/download.dart';
import 'package:castelturismo/utils/styles.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  List<Dimora> _dimore = [];
  bool _isLoading = false;
  double currentPage = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!;
      });
    });

    // fetch dimore based on id
    Future.delayed(Duration.zero).then((_) {
      setState(() => _isLoading = true);
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      bool filtersExist = Provider.of<Filters>(context, listen: false)
          .formattedFiltersId
          .isNotEmpty;

      if (filtersExist) {
        Download.getFilteredDimore(context).then(
          (dimore) => setState(() {
            _dimore = dimore;
            _isLoading = false;
          }),
        );
      } else {
        Download.getDimore(id: routeArgs["id"]).then(
          (zona) => setState(() {
            _zona = zona;
            _dimore = zona!.dimore;
            _isLoading = false;
          }),
        );
      }
    });

    super.initState();
  }

  void goToIntroDimora(Dimora dimora) {
    Navigator.of(context)
        .pushNamed("/intro-dimora", arguments: {"dimora": dimora});
  }

  Widget _pageBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_dimore.isEmpty) {
      return const Center(
        child: Text("An error occurred"),
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
      backgroundColor: Colors.black,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        if (index == 0) {
          Navigator.of(context).pushNamed(
            "/servizi",
            arguments: {"title": "Ristoro\\Bar"},
          );
        } else if (index == 1) {
          Navigator.of(context).pushNamed(
            "/servizi",
            arguments: {"title": "Hotel", "dimore": _zona?.hotels},
          );
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Image.asset("assets/iconabar.png", width: 40, height: 40),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/iconahotel.png", width: 42, height: 42),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Image.asset("assets/iconapreferiti.png", width: 48, height: 48),
          label: "",
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
