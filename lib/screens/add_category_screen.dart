import 'package:flutter/material.dart';
import 'package:mockup_v2/widgets/help_dialog.dart'; // Importiere das Hilfedialog-Widget

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  // Controller zur Steuerung der Texteingabe im TextField
  final TextEditingController _categoryNameController = TextEditingController();
  // Variable zur Speicherung der Fehlermeldung
  String? _errorMessage;
  // Variable für das ausgewählte Icon, mit einem Standardwert initialisiert
  IconData _selectedIcon = Icons.category;

  // Eine Platzhalterliste der existierenden Kategorien für die Validierung
  // In einer realen App würde diese Liste als Parameter von CategoriesScreen übergeben werden.
  final List<String> _existingCategories = [
    'Obst & Gemüse',
    'Milchprodukte',
    'Brot & Backwaren',
  ];

  // Mock-Liste von Icons zur Auswahl
  final List<IconData> _iconOptions = const [
    Icons.local_florist,
    Icons.bakery_dining,
    Icons.lunch_dining,
    Icons.fastfood,
    Icons.sports_bar,
    Icons.local_drink,
    Icons.icecream,
    Icons.shopping_cart,
    Icons.restaurant_menu,
    Icons.kitchen,
    Icons.pets,
    Icons.home_work,
    Icons.medication,
    Icons.school,
    Icons.toys,
    Icons.fitness_center,
  ];

  // Zeigt einen Hilfedialog an.
  void _showHelpDialog() {
    final List<Map<String, dynamic>> helpPages = [
      {
        'title': 'Neue Kategorie',
        'content':
            'Hier können Sie eine neue Kategorie anlegen. Geben Sie einen Namen ein und wählen Sie ein passendes Icon aus.',
      },
      {
        'title': 'Icon auswählen',
        'content':
            'Tippen Sie auf das Icon, um einen Dialog mit einer Auswahl an Icons zu öffnen.',
      },
      {
        'title': 'Speichern',
        'content':
            'Tippen Sie auf das Speichern-Icon, um die neue Kategorie hinzuzufügen. '
            'Der Name muss einzigartig sein.',
      },
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return HelpDialog(pages: helpPages);
      },
    );
  }

  // Zeigt einen Dialog zur Auswahl eines Icons an
  void _showIconPickerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Icon auswählen'),
        content: SizedBox(
          width: double.maxFinite,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: _iconOptions.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final icon = _iconOptions[index];
              return IconButton(
                icon: Icon(
                  icon,
                  size: 40,
                  color: _selectedIcon == icon
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey[700],
                ),
                onPressed: () {
                  setState(() {
                    _selectedIcon = icon;
                  });
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _saveCategory() {
    final newCategoryName = _categoryNameController.text.trim();

    // Überprüfe, ob die Eingabe leer ist
    if (newCategoryName.isEmpty) {
      setState(() {
        _errorMessage = 'Bitte gib einen Namen für die Kategorie ein.';
      });
      return;
    }

    // Überprüfe, ob der Kategoriename bereits existiert
    if (_existingCategories.any(
      (category) => category.toLowerCase() == newCategoryName.toLowerCase(),
    )) {
      setState(() {
        _errorMessage = 'Diese Kategorie existiert bereits.';
      });
      return;
    }

    // Wenn die Validierung erfolgreich ist, kann die Kategorie gespeichert werden
    // TODO: Hier die Logik zum Speichern der neuen Kategorie und des Icons hinzufügen
    debugPrint(
      'Neue Kategorie hinzugefügt: $newCategoryName mit Icon $_selectedIcon',
    );

    // Entferne die Fehlermeldung und gehe zurück zum vorherigen Bildschirm
    setState(() {
      _errorMessage = null;
    });
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neue Kategorie'),
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Hilfe',
            onPressed: _showHelpDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _categoryNameController,
              decoration: InputDecoration(
                labelText: 'Kategoriename',
                errorText:
                    _errorMessage, // Zeigt die Fehlermeldung an, wenn vorhanden
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Widget zur Icon-Auswahl
            ListTile(
              leading: Icon(_selectedIcon, size: 32),
              title: const Text('Icon auswählen'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: _showIconPickerDialog,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[300],
        child: Row(
          children: [
            const Spacer(),
            IconButton(
              onPressed: _saveCategory,
              icon: const Icon(Icons.save),
              tooltip: 'Kategorie speichern',
              iconSize: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}
