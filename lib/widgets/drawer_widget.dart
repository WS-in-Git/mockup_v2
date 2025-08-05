import 'package:flutter/material.dart';
import 'package:mockup_v2/screens/items_screen.dart';
import 'package:mockup_v2/screens/categories_screen.dart'; // Importiert den neuen Bildschirm

class DrawerWidget extends StatelessWidget {
  // Liste aller Einkaufslisten, die im Drawer angezeigt werden.
  final List<Map<String, dynamic>> shoppingLists;
  // Index der aktuell ausgewählten Liste, um sie hervorzuheben.
  final int currentListIndex;
  // Callback-Funktion, die aufgerufen wird, wenn eine neue Liste ausgewählt wird.
  final Function(int) onListSelected;

  const DrawerWidget({
    super.key,
    required this.shoppingLists,
    required this.currentListIndex,
    required this.onListSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Hole die inversePrimary Farbe aus dem Theme, um eine hellere Variante zu erstellen
    final Color headerColor = Theme.of(context).colorScheme.inversePrimary;
    // Erstelle eine blassere Variante der Header-Farbe für den Listenbereich
    final Color listSectionColor = Color.alphaBlend(
      Colors.white.withOpacity(0.85),
      headerColor,
    );
    final Color selectedItemColor = Color.alphaBlend(
      Colors.white.withOpacity(0.6),
      headerColor,
    );

    return Drawer(
      // Nutzt ein Column-Widget, um die Hauptbereiche vertikal anzuordnen
      child: SafeArea(
        top: false, // Deaktiviert den sicheren Bereich oben
        left: false,
        right: false,
        child: Column(
          children: [
            // Header für den Drawer als Container, der die volle Breite einnimmt
            Container(
              height: 107.0, // Höhe auf ca. 2/3 des Standardwerts verkleinert
              width: double
                  .infinity, // Stellt sicher, dass der Container die volle Breite einnimmt
              decoration: BoxDecoration(color: headerColor),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              alignment: Alignment.bottomLeft,
              child: const Text(
                'Meine Listen',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Expanded-Widget, um den verbleibenden Platz für die scrollbare Liste zu nutzen
            Expanded(
              child: Container(
                color:
                    listSectionColor, // Hintergrundfarbe für den gesamten Listenbereich
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // Schleife, um die verfügbaren Listen anzuzeigen.
                    for (int i = 0; i < shoppingLists.length; i++)
                      ListTile(
                        // Setzt die Hintergrundfarbe der Liste
                        tileColor: i == currentListIndex
                            ? selectedItemColor
                            : null,
                        title: Text(
                          shoppingLists[i]['name'],
                          style: TextStyle(
                            fontSize: i == currentListIndex
                                ? 20.0
                                : 18.0, // Schriftgröße um 2 Punkte erhöht, wenn die Liste ausgewählt ist
                            fontWeight: i == currentListIndex
                                ? FontWeight.bold
                                : FontWeight
                                      .normal, // Schrift fett, wenn die Liste ausgewählt ist
                          ),
                        ),
                        // Hebt die aktuell ausgewählte Liste hervor.
                        selected: i == currentListIndex,
                        onTap: () {
                          onListSelected(i);
                        },
                      ),
                  ],
                ),
              ),
            ),
            // Start des visuellen Verwaltungsbereichs mit grauem Hintergrund am unteren Rand
            Container(
              color: Colors
                  .grey[300], // Helle graue Hintergrundfarbe für den Container
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Verwaltung',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0, // Schriftgröße um 2 Punkte erhöht
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.library_add),
                    title: const Text(
                      'Artikel erfassen',
                      style: TextStyle(
                        fontSize: 16.0,
                      ), // Schriftgröße um 2 Punkte erhöht
                    ),
                    onTap: () {
                      // Schließt den Drawer
                      Navigator.pop(context);
                      // Navigiert zum Bildschirm zum Erfassen von Artikeln
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ItemsScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.category),
                    title: const Text(
                      'Kategorie anlegen',
                      style: TextStyle(
                        fontSize: 16.0,
                      ), // Schriftgröße um 2 Punkte erhöht
                    ),
                    onTap: () {
                      // Schließt den Drawer
                      Navigator.pop(context);
                      // Navigiert zum Bildschirm zum Anlegen von Kategorien
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CategoriesScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
