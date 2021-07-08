import 'package:delimeals/widgets/drawer.dart';
import 'package:flutter/material.dart';
import './category_screen.dart';
import './favorite_screen.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsScreen({this.favoriteMeals});
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> _pages;

  void initState() {
    _pages = [
      {'page': CategoryScreen(), 'title': "Category"},
      {
        'page': FavoritesScreen(favoriteMeals: widget.favoriteMeals),
        'title': "Favorite Recipes"
      },
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_pages[_selectedIndex]['title']),
      ),
      drawer: CustomDrawer(),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedIndex,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Category"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorites")
        ],
      ),
    );
  }
}
