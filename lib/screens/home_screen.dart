import 'package:flutter/material.dart';
import 'package:mockup_v2/widgets/drawer_widget.dart';
import 'package:mockup_v2/widgets/help_dialog.dart'; // Import des neuen HelpDialog-Widgets

// Dieser HomeScreen ist ein StatelessWidget, da er seinen Zustand nicht ändert.
// Er dient als einfacher Startpunkt für die App.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Die Daten für die Hilfeseiten.
    // Jede Map repräsentiert eine Seite mit Titel, Inhalt und einem optionalen Bild.
    const List<Map<String, dynamic>> helpPages = [
      {
        'title': 'Hilfe: Startseite',
        'content':
            'Dies ist der Hilfetext für die Startseite. Hier finden Sie eine Liste Ihrer Favoriten, Clouds und sonstigen Elemente. Tippen Sie auf ein Element, um die Details zu sehen.',
      },
      {
        'title': 'Navigation',
        'content':
            'Benutzen Sie den Drawer (das Menü-Icon oben links), um zwischen den verschiedenen Bereichen der App zu wechseln.',
      },
      {
        'title': 'Listenelemente',
        'content':
            'Die Liste ist in Gruppen unterteilt. Jedes Element hat ein Icon und einen Titel. Tippen Sie darauf, um eine Aktion auszulösen.',
      },
    ];

    // Der Scaffold bietet die grundlegende visuelle Struktur der App.
    // Er enthält die AppBar, den Body und jetzt auch den Drawer.
    return Scaffold(
      appBar: AppBar(
        title: const Text('mockup_v2'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Die `actions` Eigenschaft nimmt eine Liste von Widgets entgegen,
        // die auf der rechten Seite der AppBar angezeigt werden.
        actions: <Widget>[
          IconButton(
            // Ein Icon für den Hilfe-Button.
            icon: const Icon(Icons.help_outline),
            tooltip: 'Hilfe', // Text, der bei langem Drücken angezeigt wird.
            onPressed: () {
              // Beim Drücken des Buttons wird ein Dialog angezeigt.
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // Der HelpDialog wird mit den vorbereiteten Hilfeseiten erstellt.
                  return const HelpDialog(pages: helpPages);
                },
              );
            },
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: ListView(
        // Ein ListView ermöglicht das Scrollen der Inhalte.
        // Das Padding ist auf null gesetzt, um die Elemente enger zusammenzuschieben.
        padding: EdgeInsets.zero,
        children: <Widget>[
          // ----- Gruppe 1: Meine Favoriten -----
          ListTile(
            // Dieses ListTile dient als Gruppen-Überschrift.
            // Es hat einen größeren, fetten Titel und kein Untertitel oder Icon.
            title: const Text(
              'Meine Favoriten',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            dense: true,
            leading: const Icon(Icons.star, color: Colors.amber),
            title: const Text(
              'Titel des ersten Elements',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Beschreibung für das erste Element.',
              style: TextStyle(fontSize: 12.0),
            ),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            dense: true,
            leading: const Icon(Icons.favorite, color: Colors.red),
            title: const Text(
              'Titel des zweiten Elements',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Beschreibung für das zweite Element.',
              style: TextStyle(fontSize: 12.0),
            ),
            onTap: () {},
          ),
          const Divider(height: 1),

          // ----- Gruppe 2: Meine Clouds -----
          ListTile(
            // Dieses ListTile dient als Gruppen-Überschrift.
            // Es hat einen größeren, fetten Titel und kein Untertitel oder Icon.
            title: const Text(
              'Meine Clouds',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            dense: true,
            leading: const Icon(Icons.cloud, color: Colors.blue),
            title: const Text(
              'Titel des dritten Elements',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Beschreibung für das dritte Element.',
              style: TextStyle(fontSize: 12.0),
            ),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            dense: true,
            leading: const Icon(Icons.access_alarm, color: Colors.teal),
            title: const Text(
              'Titel des vierten Elements',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Beschreibung für das vierte Element.',
              style: TextStyle(fontSize: 12.0),
            ),
            onTap: () {},
          ),
          const Divider(height: 1),

          // ----- Gruppe 3: Sonstiges -----
          ListTile(
            // Dieses ListTile dient als Gruppen-Überschrift.
            // Es hat einen größeren, fetten Titel und kein Untertitel oder Icon.
            title: const Text(
              'Sonstiges',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            dense: true,
            leading: const Icon(
              Icons.battery_charging_full,
              color: Colors.green,
            ),
            title: const Text(
              'Titel des fünften Elements',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Beschreibung für das fünfte Element.',
              style: TextStyle(fontSize: 12.0),
            ),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            dense: true,
            leading: const Icon(Icons.camera_alt, color: Colors.orange),
            title: const Text(
              'Titel des sechsten Elements',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Beschreibung für das sechste Element.',
              style: TextStyle(fontSize: 12.0),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
