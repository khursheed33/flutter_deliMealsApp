import 'dart:ui';

import 'package:delimeals/dummy_data.dart';
import 'package:flutter/material.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = '/meal-details';
  final Function toggleFavoriteMeals;
  final Function isFavorite;

  MealDetailsScreen({this.toggleFavoriteMeals, this.isFavorite});

  Widget buildIndgredients(context, text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }

  Widget buildContainer(context, Widget child) {
    return Container(
      height: 150,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.network(
                selectedMeal.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),

            buildIndgredients(context, "Ingredients"),
            Divider(),

            buildContainer(
              context,
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.amber,
                    ),
                    child: Text(
                      selectedMeal.ingredients[index],
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  );
                },
              ),
            ),
            // Steps to prepare
            buildIndgredients(context, "Steps"),
            Divider(),
            buildContainer(
              context,
              ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            "#${index + 1}",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        title: Text(
                          '${selectedMeal.steps[index]}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      // Divider
                      Divider(),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: isFavorite(mealId)
            ? Icon(
                Icons.star,
                size: 35,
              )
            : Icon(
                Icons.star_border,
                size: 35,
              ),
        onPressed: () => toggleFavoriteMeals(mealId),
      ),
    );
  }
}
