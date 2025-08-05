import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import für SVG-Bilder

class HelpDialog extends StatefulWidget {
  // Eine Liste von Seiten, die im Dialog angezeigt werden sollen.
  final List<Map<String, dynamic>> pages;

  const HelpDialog({super.key, required this.pages});

  @override
  State<HelpDialog> createState() => _HelpDialogState();
}

class _HelpDialogState extends State<HelpDialog> {
  // Der Controller für den PageView, um die Seiten zu wechseln.
  final PageController _pageController = PageController();
  // Der Index der aktuell angezeigten Seite.
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fügt einen Listener hinzu, um den aktuellen Seitenindex zu verfolgen.
    _pageController.addListener(() {
      // Aktualisiert den Zustand, wenn die Seite gewechselt wird.
      if (_pageController.page != null) {
        setState(() {
          _currentPageIndex = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Funktion, die das Icon-Widget basierend auf dem Typ erstellt.
  Widget _buildIconWidget(dynamic iconData, BuildContext context) {
    if (iconData is String && iconData.endsWith('.svg')) {
      // Wenn es sich um einen SVG-Pfad handelt, verwende SvgPicture.asset
      return SvgPicture.asset(
        iconData,
        width: 48,
        height: 48,
        // Optionaler colorFilter, falls das SVG eine einheitliche Farbe bekommen soll
        // colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
      );
    } else if (iconData is IconData) {
      // Wenn es sich um ein Material-Icon handelt, verwende das Icon-Widget
      return Icon(
        iconData,
        size: 48,
        color: Theme.of(context).colorScheme.primary,
      );
    }
    // Fallback, wenn kein Icon gefunden wird.
    return const Icon(Icons.help_outline, size: 48);
  }

  // Funktion zum Erstellen der Navigationspunkte
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.pages.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPageIndex == index ? Colors.deepPurple : Colors.grey,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Stack(
        // Verwende Stack, um das "X"-Icon zu positionieren
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Hilfe',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        // Hinzugefügt: Stellt sicher, dass der Inhalt scrollbar ist
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                // Geändert von SizedBox
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ), // Dynamische maximale Höhe
                child: PageView(
                  controller: _pageController,
                  children: widget.pages.map((page) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Ruft die neue Funktion auf, um das Icon zu erstellen
                          _buildIconWidget(page['icon'], context),
                          const SizedBox(height: 16),
                          Text(
                            page['title'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            page['content'],
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              // Ruft die neue Funktion auf, um die Navigationspunkte anzuzeigen
              _buildPageIndicator(),
            ],
          ),
        ),
      ),
      actions: [
        // Keine Buttons mehr im actions-Abschnitt, da das "X" im title-Abschnitt die Schließfunktion übernimmt.
      ],
    );
  }
}
