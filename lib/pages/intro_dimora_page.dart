import 'package:cached_network_image/cached_network_image.dart';
import 'package:castelturismo/utils/text.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../providers/favorites.dart';
import '../utils/styles.dart';
import '../models/dimora.dart';

class IntroDimoraPage extends StatefulWidget {
  const IntroDimoraPage({Key? key}) : super(key: key);

  @override
  State<IntroDimoraPage> createState() => _IntroDimoraPageState();
}

class _IntroDimoraPageState extends State<IntroDimoraPage> {
  Offset _arrowOffset = Offset.zero;
  DragStartDetails? startVerticalDragDetails;
  DragUpdateDetails? updateVerticalDragDetails;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() => _arrowOffset = const Offset(0, 0.2));
    });
    super.initState();
  }

  void toggleDimoraToFavorites() {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Dimora dimora = routeArgs["dimora"];

    Provider.of<Favorites>(context, listen: false).togglePlace(dimora);
  }

  void goToDetails(Dimora dimora) {
    Navigator.of(context).pushNamed(
      "/dimora-details",
      arguments: {"dimora": dimora},
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Dimora dimora = routeArgs["dimora"];
    bool isDimoraFavorite =
        Provider.of<Favorites>(context).containsPlace(dimora.id);

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragStart: (dragDetails) {
          startVerticalDragDetails = dragDetails;
        },
        onVerticalDragUpdate: (dragDetails) {
          updateVerticalDragDetails = dragDetails;
        },
        onVerticalDragEnd: (endDetails) {
          if (updateVerticalDragDetails == null ||
              startVerticalDragDetails == null) return;

          double dx = updateVerticalDragDetails!.globalPosition.dx -
              startVerticalDragDetails!.globalPosition.dx;
          double dy = updateVerticalDragDetails!.globalPosition.dy -
              startVerticalDragDetails!.globalPosition.dy;
          double velocity = endDetails.primaryVelocity!;

          //Convert values to be positive
          if (dx < 0) dx = -dx;
          if (dy < 0) dy = -dy;

          // allow page change only on scroll down event
          if (velocity < 0 && dx < 100) {
            goToDetails(dimora);
          }
        },
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: dimora.backgroundPath,
              imageBuilder: (ctx, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.35),
                      BlendMode.srcOver,
                    ),
                    image: NetworkImage(dimora.backgroundPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (ctx, url) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                          tooltip: TextUtils.getText(
                            "<it>Indietro</it><en>Back</en><es>Atrás</es><de>Zurück</de>",
                            context,
                          ),
                          splashRadius: 24,
                          iconSize: 36,
                          icon: Image.asset("assets/iconafrecciaback.png"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                          tooltip: TextUtils.getText(
                            "<it>Preferiti</it><en>Favorites</en><es>Ahorra</es><de>Speichert</de>",
                            context,
                          ),
                          splashRadius: 24,
                          iconSize: 56,
                          icon: isDimoraFavorite
                              ? Image.asset("assets/iconapreferitifilled.png")
                              : Image.asset("assets/iconapreferiti.png"),
                          onPressed: () => toggleDimoraToFavorites(),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dimora.nome,
                          style: titleStyle,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          dimora.introDescription(context),
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.center,
                          child: Material(
                            color: Colors.transparent,
                            child: AnimatedSlide(
                              offset: _arrowOffset,
                              duration: const Duration(milliseconds: 700),
                              onEnd: () =>
                                  setState(() => _arrowOffset = -_arrowOffset),
                              child: IconButton(
                                splashRadius: 24,
                                iconSize: 36,
                                icon: Image.asset("assets/iconafrecciagiu.png"),
                                onPressed: () => goToDetails(dimora),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
