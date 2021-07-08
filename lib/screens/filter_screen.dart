import 'package:flutter/material.dart';
import '../widgets/drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filer-screen';

  final Map<String, bool> currentFilters;
  final Function saveFilters;
  FiltersScreen({this.currentFilters, this.saveFilters});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _glutenFree = false;
  bool _vegetarian = false;

  @override
  void initState() {
    _lactoseFree = widget.currentFilters['lactose'];
    _glutenFree = widget.currentFilters['gluten'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  _buildSwitchListTile(
    String title,
    String description,
    bool filterValue,
    Function updateFilteredMeal,
  ) {
    return SwitchListTile(
      inactiveThumbColor: Colors.red,
      inactiveTrackColor: Colors.red[200],
      activeTrackColor: Theme.of(context).backgroundColor,
      activeColor: Theme.of(context).primaryColor,
      value: filterValue,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
      subtitle: Text(
        description,
        style: Theme.of(context).textTheme.headline4,
      ),
      onChanged: updateFilteredMeal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Text(
              "Filter meals with selected preferences",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Divider(),
                _buildSwitchListTile(
                  "Gluten Free",
                  "Meals without gluten Added",
                  _glutenFree,
                  (newValue) {
                    setState(
                      () {
                        _glutenFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  "Vegetarian",
                  "All Vegetarian Meals",
                  _vegetarian,
                  (newValue) {
                    setState(
                      () {
                        _vegetarian = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  "Lactose Free",
                  "Meals without Lactose",
                  _lactoseFree,
                  (newValue) {
                    setState(
                      () {
                        _lactoseFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  "Vegan Free",
                  "Meals without Vegan Added",
                  _vegan,
                  (newValue) {
                    setState(
                      () {
                        _vegan = newValue;
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
