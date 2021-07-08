import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen({this.favoriteMeals});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: favoriteMeals.isEmpty
          ? Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "There is no favorite meals  -",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                      child: Text(
                        "Add some!",
                        style: TextStyle(
                            fontFamily: 'Ralweay',
                            color: Theme.of(context).primaryColor,
                            fontSize: 18),
                      ))
                ],
              ),
            )
          : ListView.builder(
              itemCount: favoriteMeals.length,
              itemBuilder: (context, index) {
                return MealItems(
                  id: favoriteMeals[index].id,
                  color: Theme.of(context).primaryColor,
                  affordability: favoriteMeals[index].affordability,
                  complexity: favoriteMeals[index].complexity,
                  imageUrl: favoriteMeals[index].imageUrl,
                  title: favoriteMeals[index].title,
                  duration: favoriteMeals[index].duration,
                  // deleteItem: _removeItem,
                );
              },
            ),
    );
  }
}
