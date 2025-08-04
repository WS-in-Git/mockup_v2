import 'package:flutter/material.dart';
import 'package:mockup_v2/widgets/help_dialog.dart';

// Ein Bildschirm, um eine Einkaufsliste zu bearbeiten.
class EditListScreen extends StatefulWidget {
  final List<Map<String, dynamic>> groupedTodoItems;
  final String listName;

  const EditListScreen({
    super.key,
    required this.groupedTodoItems,
    required this.listName,
  });

  @override
  State<EditListScreen> createState() => _EditListScreenState();
}

class _EditListScreenState extends State<EditListScreen> {
  // Behalten Sie die Daten in einem lokalen Zustand, um sie bearbeiten zu können.
  late List<Map<String, dynamic>> _editedItems;
  late TextEditingController _listNameController;

  @override
  void initState() {
    super.initState();
    // Kopieren Sie die übergebenen Daten, um sie lokal bearbeiten zu können.
    _editedItems = List.from(widget.groupedTodoItems);
    _listNameController = TextEditingController(text: widget.listName);
  }

  @override
  void didUpdateWidget(EditListScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Überprüfen, ob sich der Listenname geändert hat, um den Controller zu aktualisieren.
    if (widget.listName != oldWidget.listName) {
      _listNameController.text = widget.listName;
    }
  }

  @override
  void dispose() {
    _listNameController.dispose();
    super.dispose();
  }

  // Zeigt einen Hilfedialog an.
  void _showHelpDialog() {
    // Definition der Hilfeseiten für den Bearbeitungsbildschirm.
    final List<Map<String, dynamic>> helpPages = [
      {
        'title': 'Artikel bearbeiten',
        'content':
            'Auf dieser Seite können Sie die Artikel Ihrer Liste bearbeiten. Tippen Sie auf einen Artikel, um ihn zu bearbeiten oder zu löschen. '
            'Sie können Artikel auch per Drag-and-drop neu anordnen.',
      },
      {
        'title': 'Listennamen ändern',
        'content':
            'Der Name der Liste kann direkt in der oberen Leiste neben dem Stift-Symbol geändert werden. '
            'Tippen Sie einfach auf den Text, um ihn zu bearbeiten.',
      },
      {
        'title': 'Kategorien verwalten',
        'content':
            'Über diesen Tab können Sie die Kategorien Ihrer Liste verwalten. Sie können neue Kategorien hinzufügen, bestehende umbenennen oder löschen. '
            'Artikel können Kategorien zugewiesen werden.',
      },
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Der EditListScreen ruft nun das HelpDialog-Widget auf, das sich selbst um das Schließen kümmert.
        return HelpDialog(pages: helpPages);
      },
    );
  }

  // Funktion zum Speichern der Änderungen und Zurückkehren zum Homescreen
  void _saveAndPop() {
    Navigator.of(
      context,
    ).pop({'name': _listNameController.text, 'items': _editedItems});
  }

  @override
  Widget build(BuildContext context) {
    // Hole die Hintergrundfarbe der AppBar vom App-Theme.
    final appBarColor = Theme.of(context).colorScheme.inversePrimary;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _saveAndPop, // Zurück-Button ruft _saveAndPop auf
          ),
          // Setze den Titel als zweizeiliges Widget.
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.edit, size: 20),
                  const SizedBox(width: 8),
                  // Ein Inline-TextField zur direkten Bearbeitung des Listennamens
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        controller: _listNameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none, // Entfernt die untere Linie
                          contentPadding: EdgeInsets.zero,
                        ),
                        // Schriftgröße wurde auf 22 erhöht, Fettdruck entfernt.
                        style: const TextStyle(fontSize: 22),
                        cursorColor: Colors.black,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                'bearbeiten',
                // Schriftgröße wurde auf 16 erhöht.
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: [
            // Hilfedialog-Icon in der AppBar
            IconButton(
              icon: const Icon(Icons.help_outline),
              tooltip: 'Hilfe',
              onPressed: _showHelpDialog,
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Artikel bearbeiten'),
              Tab(text: 'Kategorien verwalten'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Text('Bearbeitungsansicht für Artikel kommt hierhin.'),
            ),
            Center(
              child: Text('Verwaltungsansicht für Kategorien kommt hierhin.'),
            ),
          ],
        ),
      ),
    );
  }
}
