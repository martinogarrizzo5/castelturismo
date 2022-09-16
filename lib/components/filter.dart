import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import '../models/filtro.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Filtro>(
      builder: (context, filter, child) => Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.12),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(filter.isChecked
                ? "assets/Filtroconspunta.png"
                : "assets/Filtrosenzaspunta.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Text(
          filter.stato,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
