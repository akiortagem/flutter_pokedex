import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/view/pokemon_detail_page.dart';

import 'package:flutter_pokedex/src/features/pokemon_list/view/pokemon_list_page.dart';

import 'package:flutter_pokedex/src/core/settings/settings_controller.dart';
import 'package:flutter_pokedex/src/core/settings/settings_view.dart';

// Define a function to handle named routes in order to support
// Flutter web url navigation and deep linking.
MaterialPageRoute<void> appRoute(
  RouteSettings routeSettings,
  SettingsController settingsController,
) {
  final name = routeSettings.name ?? '/';
  final uri = Uri.parse(name); // handles web deep links too

  // ---- Dynamic: /pokemon/{pokemon_name}
  if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'pokemon') {
    if (uri.pathSegments.length < 2) {
      return _notFound(routeSettings); // e.g. /pokemon with no slug
    }
    final raw = uri.pathSegments[1]; // "{pokemon_name}" (percent-encoded)
    final pokemonName = Uri.decodeComponent(raw); // decode %20 etc.
    return MaterialPageRoute<void>(
      settings: routeSettings,
      builder: (_) => PokemonDetailPage(pokemonName: pokemonName),
    );
  }

  return MaterialPageRoute<void>(
    settings: routeSettings,
    builder: (BuildContext context) {
      switch (routeSettings.name) {
        case SettingsView.routeName:
          return SettingsView(controller: settingsController);
        case PokemonListPage.routeName:
          return const PokemonListPage();
        default:
          return const PokemonListPage();
      }
    },
  );
}

MaterialPageRoute<void> _notFound(RouteSettings s) => MaterialPageRoute<void>(
      settings: s,
      builder: (_) => const Scaffold(
        body: Center(child: Text('404 - Not found')),
      ),
    );
