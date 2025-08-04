import 'package:flutter/material.dart';

// Ein wiederverwendbares Dialog-Widget zur Anzeige von mehrseitigen Hilfetexten
// mit Bildern, Wisch-Funktionalität und Seitenanzeige.
class HelpDialog extends StatefulWidget {
  // Eine Liste von Hilfeseiten, jede als Map mit Titel, Inhalt und optionalem Bild.
  final List<Map<String, dynamic>> pages;

  const HelpDialog({super.key, required this.pages});

  @override
  State<HelpDialog> createState() => _HelpDialogState();
}

class _HelpDialogState extends State<HelpDialog> {
  // PageController zur Steuerung der PageView-Navigation.
  late final PageController _pageController;
  // Ein State-Variable, um den Index der aktuellen Seite zu speichern.
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Titel des Dialogs.
      title: const Text('Hilfe'),
      // Der content wird mit einer festen Größe für den PageView versehen.
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Der PageView wird in einem Container mit fester Höhe dargestellt.
            SizedBox(
              height: 300, // Feste Höhe, um Layout-Probleme zu vermeiden.
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.pages.length,
                // Diese Callback-Funktion wird aufgerufen, wenn die Seite wechselt.
                // Wir aktualisieren den Zustand, um den aktuellen Index zu speichern.
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final currentPage = widget.pages[index];
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Titel der aktuellen Seite.
                        Text(
                          currentPage['title'],
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        // Das Bild wurde durch einen Container mit Farbe ersetzt, um Netzwerkfehler auszuschließen.
                        if (currentPage['image'] != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Container(
                              height: 100,
                              width: 100,
                              color: Colors.blueGrey,
                              child: const Center(
                                child: Text(
                                  'Bild-Platzhalter',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        // Inhalt der aktuellen Seite.
                        Text(currentPage['content']),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Die Navigationspunkte und der Schließen-Button.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Die Punkte für die Seitenanzeige.
                Row(
                  children: List.generate(widget.pages.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      height: 8.0,
                      width: 8.0,
                      decoration: BoxDecoration(
                        // Die Farbe der Punkte wird nun durch den Zustandsindex gesteuert.
                        color: _currentPageIndex == index
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    );
                  }),
                ),
                // Schließen-Button.
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Schließen'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
