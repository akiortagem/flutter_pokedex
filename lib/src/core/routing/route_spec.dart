import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/core/routing/path_pattern.dart';
import 'package:flutter_pokedex/src/core/settings/settings_controller.dart';
import 'package:flutter_pokedex/src/core/settings/settings_view.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/view/pokemon_list_page.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/view/pokemon_detail_page.dart';

typedef RouteBuilder = Widget Function(
    BuildContext, Map<String, String> params);

class RouteSpec {
  const RouteSpec({required this.pattern, required this.builder});
  final PathPattern pattern;
  final RouteBuilder builder;
}

final List<RouteSpec> _patternRoutes = [
  RouteSpec(
    pattern: PokemonDetailPage.pattern, // '/pokemon/:pokemonName'
    builder: (ctx, params) =>
        PokemonDetailPage(pokemonName: params['pokemonName'] ?? ''),
  ),
];

MaterialPageRoute<void> appRoute(
  RouteSettings routeSettings,
  SettingsController settingsController,
) {
  final name = routeSettings.name ?? '/';
  final uri = Uri.parse(name);

  // 1) Static pages by concrete routeName
  switch (uri.path) {
    case SettingsView.routeName:
      return MaterialPageRoute<void>(
        settings: routeSettings,
        builder: (_) => SettingsView(controller: settingsController),
      );
    case PokemonListPage.routeName:
    case '/':
      return MaterialPageRoute<void>(
        settings: routeSettings,
        builder: (_) => const PokemonListPage(),
      );
  }

  // 2) Pattern pages (e.g., '/pokemon/:pokemonName')
  for (final spec in _patternRoutes) {
    final params = spec.pattern.match(uri.path);
    if (params != null) {
      return MaterialPageRoute<void>(
        settings: routeSettings,
        builder: (ctx) => spec.builder(ctx, params),
      );
    }
  }

  // 3) 404
  return MaterialPageRoute<void>(
    settings: routeSettings,
    builder: (_) => const Scaffold(
      body: Center(child: Text('404 - Not found')),
    ),
  );
}
