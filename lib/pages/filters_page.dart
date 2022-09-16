import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../components/base_app_bar.dart';
import '../components/filter.dart';
import '../providers/filters.dart';
import '../utils/text.dart';

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
        padding: const EdgeInsets.all(8.0),
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
      appBar: baseAppBar(
        context,
        title: TextUtils.getText(
            "<it>FILTRI</it><en>FILTERS</en><es>FILTROS</es><de>FILTER</de>",
            context),
      ),
      body: _buildBody(),
    );
  }
}
