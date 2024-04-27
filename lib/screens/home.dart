import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/recipes_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> recipes = [
    Recipe(id: 1, title: 'Steak', servings: '1', ingredients: 'Beef, Butter, Thyme, Ginger', steps: 'blah blah blah', source: 'N/A'),
    Recipe(id: 2, title: 'Pizza', ingredients: 'Beef, flour, sauce, cheese', steps: 'blah blah blah'),

  ];
  List<int> selectedRecipes = [];
  bool displaySearchField = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Reciper"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    displaySearchField = !displaySearchField;
                  });
                },
                icon: const Icon(Icons.search)),
            if (selectedRecipes.isNotEmpty)
              IconButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Delete selected recipes"),
                        content: const Text("Are you sure?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                removeSelectedRecipes(selectedRecipes);
                                Navigator.pop(context);
                              },
                              child: const Text("Delete")),
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel")),
                        ],
                      )),
                  icon: const Icon(Icons.delete)),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                Visibility(
                    visible: displaySearchField,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Search',
                          ),
                        ))),
                RecipeListView(
                  reloadRecipes: () {},
                  recipes: recipes,
                  onRecipesSelectionUpdate: (values) {
                    setState(() {
                      selectedRecipes = values;
                    });
                  },
                  selectedRecipesID: selectedRecipes,
                ),
              ],
            )));
  }

  void removeSelectedRecipes(List<int> values) {
    setState(() {
      recipes.removeWhere((recipe) => values.contains(recipe.id));
      selectedRecipes = [];
    });
  }
}
