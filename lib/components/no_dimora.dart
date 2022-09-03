import 'package:castelturismo/components/button.dart';
import 'package:castelturismo/utils/text.dart';
import "package:flutter/material.dart";

class NoDimora extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const NoDimora({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/empty-dimore.png",
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 19,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          if (onPressed != null)
            Button(
              text: TextUtils.getText(
                "<it>Cambia filtri</it><en>Change filters</en><es>Cambiar filtros</es><de>Filter ändern</de>",
                context,
              ),
              onPress: () =>
                  Navigator.of(context).pushReplacementNamed("/filters"),
            ),
        ],
      ),
    );
  }
}
