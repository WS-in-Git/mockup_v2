import 'package:flutter/material.dart';
import 'package:mockup_v2/screens/edit_list_screen.dart';
import 'package:mockup_v2/widgets/help_dialog.dart';
import 'package:mockup_v2/widgets/drawer_widget.dart'; // Import des neuen Drawer-Widgets

// Die Hauptseite der App, die eine Liste von Todo-Gruppen anzeigt.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Eine Liste aller Einkaufslisten.
  List<Map<String, dynamic>> _shoppingLists = [
    {
      'name': 'Einkaufsliste',
      'items': [
        {
          'category': 'Obst & Gemüse',
          'tasks': [
            {'title': 'Äpfel', 'isDone': false},
            {'title': 'Bananen', 'isDone': false},
            {'title': 'Salat', 'isDone': true},
          ],
          'isCollapsed': false,
        },
        {
          'category': 'Milchprodukte',
          'tasks': [
            {'title': 'Milch', 'isDone': false},
            {'title': 'Käse', 'isDone': true},
            {'title': 'Joghurt', 'isDone': true},
          ],
          'isCollapsed': false,
        },
        {
          'category': 'Brot & Gebäck',
          'tasks': [
            {'title': 'Vollkornbrot', 'isDone': true},
            {'title': 'Brötchen', 'isDone': true},
          ],
          'isCollapsed': false,
        },
      ],
    },
    {
      'name': 'Wochenendeinkauf',
      'items': [
        {
          'category': 'Getränke',
          'tasks': [
            {'title': 'Wasser', 'isDone': false},
            {'title': 'Cola', 'isDone': false},
          ],
          'isCollapsed': false,
        },
      ],
    },
  ];

  // Index der aktuell ausgewählten Liste.
  int _currentListIndex = 0;

  // Definition der Hilfeseiten für den Startbildschirm.
  final List<Map<String, dynamic>> _helpPages = [
    {
      'title': 'Anleitung zur Liste',
      'content':
          'Tippen Sie auf einen Artikel, um ihn als erledigt zu markieren oder die Markierung aufzuheben. '
          'Sie können die Liste der Artikel innerhalb einer Kategorie per Drag-and-drop neu anordnen.',
    },
    {
      'title': 'Kategorien',
      'content':
          'Tippen Sie auf eine Kategoriezeile, um die Liste ein- oder auszublenden. '
          'Die Zahlen neben der Kategorie zeigen die Anzahl der erledigten und unerledigten Artikel an.',
    },
  ];

  // Ändert den Zustand (erledigt/unerledigt) eines bestimmten Todo-Items.
  void _toggleTodoItem(int groupIndex, int taskIndex, bool? isDone) {
    setState(() {
      _shoppingLists[_currentListIndex]['items'][groupIndex]['tasks'][taskIndex]['isDone'] =
          isDone!;
    });
  }

  // Schaltet den Einklapp-Zustand einer Gruppe um.
  void _toggleGroupCollapse(int index) {
    setState(() {
      _shoppingLists[_currentListIndex]['items'][index]['isCollapsed'] =
          !_shoppingLists[_currentListIndex]['items'][index]['isCollapsed'];
    });
  }

  // Navigiert zum Bearbeitungsbildschirm und aktualisiert die Liste, falls Änderungen vorgenommen wurden.
  void _editList() async {
    final currentList = _shoppingLists[_currentListIndex];
    // Warten auf das Ergebnis des Bearbeitungsbildschirms.
    final updatedData = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditListScreen(
          groupedTodoItems: currentList['items'],
          listName: currentList['name'],
        ),
      ),
    );

    // Wenn Daten zurückgegeben wurden, aktualisieren wir den Zustand.
    if (updatedData != null) {
      setState(() {
        _shoppingLists[_currentListIndex]['name'] = updatedData['name'];
        _shoppingLists[_currentListIndex]['items'] = updatedData['items'];
      });
    }
  }

  // Ändert die aktuell ausgewählte Liste basierend auf dem Index.
  void _onListSelected(int index) {
    setState(() {
      _currentListIndex = index;
    });
    Navigator.pop(context); // Schließt den Drawer
  }

  // Zeigt einen Hilfedialog an.
  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Ruft das zentrale HelpDialog-Widget mit den spezifischen Hilfeseiten auf.
        return HelpDialog(pages: _helpPages);
      },
    );
  }

  // Klappt alle Kategorien auf
  void _expandAllCategories() {
    setState(() {
      for (var item in _shoppingLists[_currentListIndex]['items']) {
        item['isCollapsed'] = false;
      }
    });
  }

  // Klappt alle Kategorien zu
  void _collapseAllCategories() {
    setState(() {
      for (var item in _shoppingLists[_currentListIndex]['items']) {
        item['isCollapsed'] = true;
      }
    });
  }

  // Überprüft, ob es vollständig erledigte Kategorien gibt.
  bool _hasCompletedCategories() {
    return _shoppingLists[_currentListIndex]['items'].any((item) {
      final tasks = item['tasks'] as List<Map<String, dynamic>>;
      return tasks.isNotEmpty && tasks.every((task) => task['isDone']);
    });
  }

  // Klappt nur vollständig erledigte Kategorien zu.
  void _collapseCompletedCategories() {
    setState(() {
      for (var item in _shoppingLists[_currentListIndex]['items']) {
        final tasks = item['tasks'] as List<Map<String, dynamic>>;
        if (tasks.isNotEmpty && tasks.every((task) => task['isDone'])) {
          item['isCollapsed'] = true;
        }
      }
    });
  }

  // Überprüft, ob alle Kategorien eingeklappt sind.
  bool _areAllCategoriesCollapsed() {
    return _shoppingLists[_currentListIndex]['items'].every(
      (item) => item['isCollapsed'] == true,
    );
  }

  // Erstellt die Benutzeroberfläche der App.
  @override
  Widget build(BuildContext context) {
    // Die aktuelle Liste, die angezeigt werden soll.
    final currentList = _shoppingLists[_currentListIndex];
    // Hole die Hintergrundfarbe der AppBar, um sie auch für die BottomAppBar zu verwenden.
    final appBarColor = Theme.of(context).colorScheme.inversePrimary;

    // Bestimme das Icon und die Aktion für den dynamischen Button.
    final bool allCollapsed = _areAllCategoriesCollapsed();
    // Überprüfe, ob es aufgeklappte Kategorien mit nur erledigten Items gibt.
    final bool hasExpandedCompletedCategories =
        _shoppingLists[_currentListIndex]['items'].any((item) {
          final tasks = item['tasks'] as List<Map<String, dynamic>>;
          return !item['isCollapsed'] &&
              tasks.isNotEmpty &&
              tasks.every((task) => task['isDone']);
        });

    IconData icon;
    String tooltip;
    VoidCallback onPressed;

    if (allCollapsed) {
      // Zustand 1: Alle Kategorien sind eingeklappt. Nächster Schritt: Aufklappen.
      icon = Icons.unfold_more;
      tooltip = 'Alle Kategorien aufklappen';
      onPressed = _expandAllCategories;
    } else if (hasExpandedCompletedCategories) {
      // Zustand 2: Es gibt aufgeklappte, vollständig erledigte Kategorien. Nächster Schritt: Diese zuklappen.
      icon = Icons.check_circle_outline;
      tooltip = 'Erledigte Kategorien zuklappen';
      onPressed = _collapseCompletedCategories;
    } else {
      // Zustand 3: Standardfall. Alle Kategorien zuklappen.
      // Dies deckt den Fall ab, dass alle aufgeklappt sind, oder ein gemischter Zustand vorliegt,
      // aber keine erledigte Kategorie existiert oder alle erledigten bereits zugeklappt sind.
      icon = Icons.unfold_less;
      tooltip = 'Alle Kategorien zuklappen';
      onPressed = _collapseAllCategories;
    }

    return Scaffold(
      appBar: AppBar(
        // Anzeige des Listennamens in der AppBar
        title: Text(currentList['name']),
        backgroundColor: appBarColor,
        // Hinzufügen des Hilfe-Icons
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Hilfe',
            onPressed: _showHelpDialog,
          ),
        ],
      ),
      // Der Drawer, der über den "onTap" aufgerufen wird.
      drawer: DrawerWidget(
        shoppingLists: _shoppingLists,
        currentListIndex: _currentListIndex,
        onListSelected: _onListSelected,
      ),
      body: ReorderableListView(
        // Hier rendern wir die einzelnen Gruppen von Todo-Items.
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final item = _shoppingLists[_currentListIndex]['items'].removeAt(
              oldIndex,
            );
            _shoppingLists[_currentListIndex]['items'].insert(newIndex, item);
          });
        },
        children: [
          // Wir erstellen eine expandierbare Kachel für jede Gruppe.
          for (int index = 0; index < currentList['items'].length; index++)
            _buildGroupExpansionTile(index),
        ],
      ),
      // Eine Bottom-App-Bar wurde hinzugefügt.
      bottomNavigationBar: BottomAppBar(
        color: appBarColor, // Die Farbe der Appbar wird hier wiederverwendet
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Bearbeiten-Icon als IconButton
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Liste bearbeiten',
              onPressed: _editList,
            ),
            // Dynamischer Button für die Aufklapp-/Zuklapp-Funktion.
            IconButton(
              icon: Icon(icon),
              tooltip: tooltip,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }

  // Erstellt einen auf- und zuklappbaren Abschnitt für eine Gruppe von Todo-Items.
  Widget _buildGroupExpansionTile(int groupIndex) {
    // Bestimmt den anzuzeigenden Kategorienamen mit oder ohne Artikelanzahl.
    final currentList = _shoppingLists[_currentListIndex];
    final categoryName = currentList['items'][groupIndex]['category'];
    final tasks =
        currentList['items'][groupIndex]['tasks'] as List<Map<String, dynamic>>;
    final undoneCount = tasks.where((task) => !task['isDone']).length;
    final doneCount = tasks.where((task) => task['isDone']).length;
    final totalCount = undoneCount + doneCount;

    return Padding(
      key: ValueKey(currentList['items'][groupIndex]),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      child: Column(
        children: [
          // Der Kategorietitel, der klickbar ist, um die Liste zu erweitern oder zu schließen.
          GestureDetector(
            onTap: () => _toggleGroupCollapse(groupIndex),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Anzeige des Kategorienamens und der Artikelanzahl im eingeklappten Zustand
                Row(
                  children: [
                    Text(
                      categoryName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        // Farbwechsel basierend auf dem eingeklappten Zustand
                        color: currentList['items'][groupIndex]['isCollapsed']
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                    if (currentList['items'][groupIndex]['isCollapsed'])
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          // Gesamtzahl in Grau
                          Text(
                            '$totalCount',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          // Erledigte Anzahl in Grau, gefolgt von der unerledigten Anzahl in Grün
                          Text(
                            '( $doneCount / ',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$undoneCount',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          // Grüner Container mit weißem Häkchen-Icon
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            padding: const EdgeInsets.all(2.0),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16.0,
                            ),
                          ),
                          const Text(
                            ')',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
          // Die Aufgabenliste wird nur angezeigt, wenn sie nicht eingeklappt ist.
          if (!currentList['items'][groupIndex]['isCollapsed'])
            Column(
              children: [
                for (
                  int taskIndex = 0;
                  taskIndex < currentList['items'][groupIndex]['tasks'].length;
                  taskIndex++
                )
                  Column(
                    children: [
                      Padding(
                        // Fügt ein linkes Padding von 12.0 hinzu
                        padding: const EdgeInsets.only(
                          left: 12.0,
                          top: 0,
                          bottom: 0,
                        ),
                        child: GestureDetector(
                          onTap: () => _toggleTodoItem(
                            groupIndex,
                            taskIndex,
                            !currentList['items'][groupIndex]['tasks'][taskIndex]['isDone'],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  currentList['items'][groupIndex]['tasks'][taskIndex]['title'],
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    height: 1.0,
                                    decoration:
                                        currentList['items'][groupIndex]['tasks'][taskIndex]['isDone']
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Icon(
                                currentList['items'][groupIndex]['tasks'][taskIndex]['isDone']
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                size: 24.0,
                                color:
                                    currentList['items'][groupIndex]['tasks'][taskIndex]['isDone']
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Fügt eine dünne Trennlinie nach jedem Artikel hinzu, die ebenfalls eingerückt ist
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: const Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
