import 'package:flutter/material.dart';

import './dummy_data.dart';
import './screens/tabs_screen.dart';
import 'screens/meal_detail_screen.dart';
import './screens/filter_screen.dart';
import './screens/category_meal_screen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _favoriteMeals = [];
  List<Meal> _availableMeals = DUMMY_MEALS;

  void _toggleFavoriteMeals(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
      // print('Favroites: $_favoriteMeals');
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      /* Testing meals whether comes under filter of not */
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

// Build method starts to run app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.tealAccent,
        canvasColor: Colors.blueGrey[100],
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                color: Color.fromRGBO(254, 254, 254, 1),
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w900,
                fontSize: 24,
              ),
              headline2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              headline3: TextStyle(
                fontFamily: 'RobotoCondensed',
                color: Colors.grey[900],
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              headline4: TextStyle(
                fontSize: 16,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
              headline5: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.grey[300],
              ),
              headline6: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
              bodyText1: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
              bodyText2: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
      ),
      debugShowCheckedModeBanner: false,
      title: "DeliMeals",
      // home: CategoryScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(favoriteMeals: _favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(
              availableMeals: _availableMeals,
            ),
        MealDetailsScreen.routeName: (ctx) => MealDetailsScreen(
              toggleFavoriteMeals: _toggleFavoriteMeals,
              isFavorite: _isMealFavorite,
            ),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              currentFilters: _filters,
              saveFilters: _setFilters,
            ),
      },
    );
  }
}
