import 'package:flutter/material.dart';
import '../screens/filter_screen.dart';

class CustomDrawer extends StatelessWidget {
  Widget buildTile(
      context, IconData icon, String title, Function screenHandler) {
    return ListTile(
      onTap: screenHandler,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
      leading: Icon(
        icon,
        color: Theme.of(context).primaryColorDark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 150,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColorDark,
            child: Text(
              "Cooking Up!",
              style: TextStyle(
                letterSpacing: 2,
                fontSize: 28,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildTile(context, Icons.set_meal, "Meals", () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          Divider(),
          buildTile(context, Icons.settings, "Filter", () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }),
        ],
      ),
    );
  }
}
