import 'package:castelturismo/components/base_app_bar.dart';
import 'package:castelturismo/components/filter.dart';
import 'package:castelturismo/providers/filters.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class FiltersPage extends StatefulWidget {
  const FiltersPage({Key? key}) : super(key: key);

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  Widget _buildBody() {
    var filters = Provider.of<Filters>(context).filters;

    if (filters == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView(
        children: filters
            .map(
              (filter) => ChangeNotifierProvider.value(
                value: filter,
                child: GestureDetector(
                  onTap: () {
                    filter.toggleCheck(context: context);
                  },
                  child: const FilterItem(),
                ),
              ),
            )
            .toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: baseAppBar(context, title: "FILTRI"),
      body: _buildBody(),
    );
  }
}
