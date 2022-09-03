import 'package:castelturismo/models/dimora.dart';
import 'package:castelturismo/providers/favorites.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class DimoraMiniCard extends StatelessWidget {
  final Dimora dimora;
  final void Function() onTap;
  final bool isFavCard;
  // card is also used in itinerari page
  final int? pathNumber;

  const DimoraMiniCard(
    this.dimora, {
    required this.onTap,
    // default to favorite card
    this.isFavCard = true,
    this.pathNumber,
    Key? key,
  }) : super(key: key);

  Widget buildFavIcon(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        tooltip: "Favorite",
        splashRadius: 24,
        iconSize: 48,
        icon: Provider.of<Favorites>(context).containsPlace(dimora.id)
            ? Image.asset(
                "assets/iconapreferitifilled.png",
                height: 48,
              )
            : Image.asset(
                "assets/iconapreferiti.png",
                height: 48,
              ),
        onPressed: () =>
            Provider.of<Favorites>(context, listen: false).togglePlace(dimora),
      ),
    );
  }

  Widget buildPathNumber(int number) {
    return Chip(
      backgroundColor: Colors.black,
      label: Text(
        "$number",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 16),
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
          border: Border.all(
            color: const Color.fromARGB(255, 45, 45, 45),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            if (isFavCard) buildFavIcon(context),
            if (pathNumber != null) buildPathNumber(pathNumber!),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                dimora.nome,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
