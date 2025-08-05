import 'package:flutter/material.dart';
import 'package:mockup_v2/widgets/help_dialog.dart'; // Importiere das Hilfedialog-Widget

// Ein Bildschirm, um Artikel zu verwalten.
class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  // Mock-Daten für die erfassten Artikel nach Kategorie.
  final List<Map<String, dynamic>> _itemGroups = [
    {
      'category': 'Obst & Gemüse',
      'items': ['Äpfel', 'Bananen', 'Salat', 'Tomaten'],
      'isExpanded': false,
    },
    {
      'category': 'Milchprodukte',
      'items': ['Milch', 'Käse', 'Joghurt'],
      'isExpanded': false,
    },
    {
      'category': 'Brot & Backwaren',
      'items': ['Vollkornbrot', 'Brötchen'],
      'isExpanded': false,
    },
  ];

  // Hält den Index des aktuell geöffneten ExpansionPanel
  int? _expandedPanelIndex;

  // Zeigt einen Hilfedialog an.
  void _showHelpDialog() {
    final List<Map<String, dynamic>> helpPages = [
      {
        'title': 'Artikel erfassen',
        'content':
            'Hier können Sie neue Artikel hinzufügen, bestehende bearbeiten oder löschen. '
            'Die Artikel sind nach Kategorien geordnet, die Sie ausklappen können.',
      },
      {
        'title': 'Neue Artikel hinzufügen',
        'content':
            'Tippen Sie auf den "+" Button unten rechts, um einen neuen Artikel zu erfassen.',
      },
      {
        'title': 'Artikel löschen',
        'content':
            'Tippen Sie auf das rote Mülleimer-Icon neben einem Artikel, um diesen aus der Liste zu entfernen.',
      },
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HelpDialog(pages: helpPages);
      },
    );
  }

  // Hier kommt die Logik zum Hinzufügen eines neuen Artikels hin
  void _addNewItem() {
    // TODO: Hier die Logik zum Hinzufügen eines neuen Artikels hinzufügen
    // Zum Beispiel ein Dialog, der die Eingabe eines neuen Artikels ermöglicht
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Die AppBar, die die graue Farbe aus dem Drawer hat.
      appBar: AppBar(
        // Fügt das Icon zum Titel hinzu, um es mit dem Drawer abzugleichen.
        title: const Row(
          children: [
            Icon(Icons.library_add),
            SizedBox(width: 8),
            Text('Artikel erfassen'),
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[100], // Ein leichter Hintergrund für den Body
          child: ExpansionPanelList.radio(
            // Ein Callback, der aufgerufen wird, wenn ein Panel geöffnet oder geschlossen wird.
            // Der Index des geöffneten Panels wird aktualisiert.
            initialOpenPanelValue: _expandedPanelIndex,
            children: _itemGroups.map<ExpansionPanelRadio>((group) {
              return ExpansionPanelRadio(
                value: group['category'] as String,
                // Der Header des Panels zeigt den Kategorienamen
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(
                      group['category'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  );
                },
                // Der Body des Panels listet die Artikel der Kategorie auf
                body: Column(
                  children: (group['items'] as List<String>).map((item) {
                    return ListTile(
                      title: Text(item),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        color: Colors.red,
                        onPressed: () {
                          // TODO: Hier die Logik zum Löschen des Artikels hinzufügen
                        },
                      ),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      // Fügt eine BottomAppBar mit einem "Hinzufügen"-Button hinzu.
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[300], // Passend zur AppBar
        child: Row(
          children: [
            const Spacer(),
            IconButton(
              onPressed: _addNewItem,
              icon: const Icon(Icons.add),
              tooltip: 'Neuen Artikel hinzufügen',
              iconSize: 32.0, // Macht das Icon größer
            ),
          ],
        ),
      ),
    );
  }
}
