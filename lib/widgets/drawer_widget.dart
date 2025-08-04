import 'package:flutter/material.dart';

// Ein wiederverwendbares Widget für den Drawer der App.
class DrawerWidget extends StatelessWidget {
  final List<Map<String, dynamic>> shoppingLists;
  final int currentListIndex;
  final Function(int) onListSelected;

  const DrawerWidget({
    super.key,
    required this.shoppingLists,
    required this.currentListIndex,
    required this.onListSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Der Drawer ist ein Material Design Panel, das von der Seite des Scaffolds hereinrutscht.
    return Drawer(
      child: ListView(
        // Wichtiger Hinweis: Entfernen Sie jegliches Padding vom ListView.
        // Andernfalls kann es zu Problemen mit dem Status-Bar-Bereich kommen.
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Das DrawerHeader-Widget bietet einen Standard-Header für den Drawer.
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Text(
              'Meine Einkaufslisten',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          // Dynamisch generierte Liste von ListTiles für jede Einkaufsliste.
          ...List.generate(shoppingLists.length, (index) {
            final listName = shoppingLists[index]['name'] as String;
            return ListTile(
              // Fügt eine visuelle Markierung für die aktuell ausgewählte Liste hinzu.
              selected: index == currentListIndex,
              leading: const Icon(Icons.list_alt),
              title: Text(listName),
              onTap: () {
                onListSelected(index);
              },
            );
          }),
          // Eine Trennlinie für die Übersichtlichkeit.
          const Divider(),
          // Der neue Bereich zum Erstellen einer neuen Liste.
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Neue Liste'),
            onTap: () {
              // TODO: Hier die Logik zum Erstellen einer neuen Liste hinzufügen.
              Navigator.pop(context); // Schließt den Drawer nach dem Antippen.
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Einstellungen'),
            onTap: () {
              // TODO: Hier die Logik für die Navigation zu den Einstellungen hinzufügen.
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
