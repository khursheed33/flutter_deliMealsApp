import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  // receiving available meals from main file
  final List<Meal> availableMeals;
  final List<Meal> favoriteMeals;
  CategoryMealsScreen({this.availableMeals, this.favoriteMeals});

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  var _loadedInitData = false;
  String categoryTitle;
  Color categoryColor;
  List<Meal> displayedMeals;
  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final categoryArgs =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      categoryTitle = categoryArgs['title'];
      final categoryId = categoryArgs['id'];
      categoryColor = categoryArgs['color'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  // void _removeItem(String mealId) {
  //   setState(() {
  //     displayedMeals.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: categoryColor,
        title: Text(categoryTitle),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: displayedMeals.length,
        itemBuilder: (context, index) {
          return MealItems(
            id: displayedMeals[index].id,
            color: categoryColor,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
            imageUrl: displayedMeals[index].imageUrl,
            title: displayedMeals[index].title,
            duration: displayedMeals[index].duration,
            // deleteItem: _removeItem,
          );
        },
      ),
    );
  }
}
