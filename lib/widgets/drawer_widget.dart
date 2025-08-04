import 'package:flutter/material.dart';

// Ein wiederverwendbares Widget für den Drawer der App.
class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Der Drawer ist ein Material Design Panel, das von der Seite des Scaffolds hereinrutscht.
    return Drawer(
      child: ListView(
        // Wichtiger Hinweis: Entfernen Sie jegliches Padding vom ListView.
        // Andernfalls kann es zu Problemen mit dem Status-Bar-Bereich kommen.
        padding: EdgeInsets.zero,
        children: const <Widget>[
          // Das DrawerHeader-Widget bietet einen Standard-Header für den Drawer.
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Text(
              'Drawer Header',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          // ListTile ist ein gängiges Widget für Zeilen in einem Drawer.
          ListTile(leading: Icon(Icons.home), title: Text('Startseite')),
          ListTile(leading: Icon(Icons.settings), title: Text('Einstellungen')),
        ],
      ),
    );
  }
}
