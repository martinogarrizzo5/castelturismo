import 'package:castelturismo/components/base_app_bar.dart';
import 'package:flutter/material.dart';

class ServiziPage extends StatelessWidget {
  const ServiziPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: baseAppBar(context, title: routeArgs["title"]),
    );
  }
}
