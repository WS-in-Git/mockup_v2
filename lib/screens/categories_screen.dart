import 'package:flutter/material.dart';
import 'package:mockup_v2/widgets/help_dialog.dart'; // Importiere das Hilfedialog-Widget
import 'package:mockup_v2/screens/add_category_screen.dart'; // Importiere den neuen Bildschirm

// Ein Bildschirm, um Kategorien zu verwalten.
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // Mock-Daten für die Kategorien. Jetzt mit Icons.
  // Beachten Sie, dass der Typ hier List<Map<String, dynamic>> ist.
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Obst & Gemüse', 'icon': Icons.local_florist},
    {'name': 'Milchprodukte', 'icon': Icons.bakery_dining},
    {'name': 'Brot & Backwaren', 'icon': Icons.lunch_dining},
  ];

  // Hier kommt die Logik zum Hinzufügen einer neuen Kategorie hin
  void _addNewCategory() {
    // Navigiere zum neuen Bildschirm, um eine Kategorie hinzuzufügen.
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const AddCategoryScreen()));
  }

  // Hier kommt die Logik zum Löschen einer Kategorie hin
  void _deleteCategory(int index) {
    // TODO: Hier die Logik zum Löschen einer Kategorie hinzufügen
    // setState(() {
    //   _categories.removeAt(index);
    // });
  }

  // Zeigt einen Hilfedialog an.
  void _showHelpDialog() {
    final List<Map<String, dynamic>> helpPages = [
      {
        'title': 'Kategorie anlegen',
        'content':
            'Hier können Sie neue Kategorien hinzufügen, bestehende bearbeiten oder löschen. ',
      },
      {
        'title': 'Neue Kategorie hinzufügen',
        'content':
            'Tippen Sie auf das "+" Icon in der unteren Leiste, um eine neue Kategorie zu erstellen.',
      },
      {
        'title': 'Kategorie löschen',
        'content':
            'Tippen Sie auf das rote Mülleimer-Icon neben einer Kategorie, um diese aus der Liste zu entfernen.',
      },
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HelpDialog(pages: helpPages);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.category),
            SizedBox(width: 8),
            Text('Kategorie anlegen'),
          ],
        ),
        backgroundColor: Colors.grey[300],
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Hilfe',
            onPressed: _showHelpDialog,
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[100], // Ein leichter Hintergrund für den Body
        child: ListView.builder(
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            return ListTile(
              // Zeigt das Icon vor dem Kategorienamen an
              leading: Icon(category['icon'] as IconData),
              title: Text(category['name'] as String),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                color: Colors.red,
                onPressed: () => _deleteCategory(index),
              ),
            );
          },
        ),
      ),
      // Fügt eine BottomAppBar mit einem "Hinzufügen"-Button hinzu.
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[300], // Passend zur AppBar
        child: Row(
          children: [
            const Spacer(),
            IconButton(
              onPressed: _addNewCategory,
              icon: const Icon(Icons.add),
              tooltip: 'Neue Kategorie hinzufügen',
              iconSize: 32.0, // Macht das Icon größer
            ),
          ],
        ),
      ),
    );
  }
}
