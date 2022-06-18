import 'package:flutter/material.dart';

AppBar baseAppBar(BuildContext context, {required String title}) {
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
    title: Text(
      title,
      style: const TextStyle(letterSpacing: 7),
    ),
  );
}
