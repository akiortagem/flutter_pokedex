import 'package:flutter_pokedex/src/core/services/poke_api_client.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/data/pkmn_details_ds.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_about_model.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_base_stats_model.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_evo_model.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_moves_model.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_page_model.dart';
import 'package:flutter_pokedex/src/shared/enums/pkmn_types.dart';

class PKMNDetailsPokeAPIDataSource implements PKMNDetailsDataSource {
  const PKMNDetailsPokeAPIDataSource({
    required this.apiClient,
  });

  final PokeApiClient apiClient;

  @override
  Future<List<PokemonDetailEvoModel>> getPokemonEvoChain(
      String pkmnName) async {
    // 1) species → evolution_chain URL
    final species = await apiClient.get('/pokemon-species/$pkmnName')
        as Map<String, dynamic>;
    final evoUrl = species['evolution_chain']?['url'] as String?;
    if (evoUrl == null) return const [];

    final evoId = _lastNumberInUrl(evoUrl);
    if (evoId == null) return const [];

    final evoChain =
        await apiClient.get('/evolution-chain/$evoId') as Map<String, dynamic>;
    final chainRoot = evoChain['chain'];
    if (chainRoot == null) return const [];

    final speciesName = (species['name'] as String?) ?? pkmnName.toLowerCase();

    // 2) locate node of current species in the chain
    final currentNode = _findNode(chainRoot, speciesName);
    if (currentNode == null) return const [];

    // 3) collect forward evolutions only
    final forwardSpecies = <String>[];
    _collectForward(currentNode, forwardSpecies);

    // 4) build ordered list: [current, ...forward]
    final orderedNames = <String>[speciesName, ...forwardSpecies];

    // 5) hydrate each with /pokemon/:name (types + official artwork)
    final seen =
        <String>{}; // avoid duplicates (some chains can repeat via branches)
    final results = <PokemonDetailEvoModel>[];

    for (final name in orderedNames) {
      final lower = name.toLowerCase();
      if (seen.contains(lower)) continue;
      seen.add(lower);

      final evo = await _hydrate(lower);
      if (evo != null && (evo.pkmnName ?? '').isNotEmpty) {
        results.add(evo);
      }
    }

    return results;
  }

  @override
  Future<PokemonDetailPageModel> getPokemonDetails(String pkmnName) async {
    final response =
        await apiClient.get('/pokemon/$pkmnName') as Map<String, dynamic>;

    // --- Basic fields
    final id = response['id'] as int?;
    final name = response['name'] as String?;

    // -- Species
    final species = response['species'] as Map<String, dynamic>? ??
        {
          'name': '',
        };

    final speciesName = species['name'] ?? 'Unknown';

    // --- Types
    final types = (response['types'] as List<dynamic>?)
        ?.map((t) => mapTypeNameToEnum(t['type']['name'] as String))
        .toList();

    // --- Artwork
    final artUrl = response['sprites']?['other']?['official-artwork']
        ?['front_default'] as String?;

    // --- About section
    final about = PokemonDetailAboutModel(
      species: response['species']?['name'] as String?,
      height: _formatHeight((response['height'] as int?) ?? 0),
      weight: _formatWeight((response['weight'] as int?) ?? 0),
      abilities: (response['abilities'] as List<dynamic>?)
          ?.map((a) => a['ability']?['name'] as String?)
          .whereType<String>()
          .join(', '),
    );

    // --- Base Stats
    final stats = response['stats'] as List<dynamic>?;
    final baseStats = PokemonDetailBaseStatsModel(
      hp: _statValue(stats, 'hp'),
      attack: _statValue(stats, 'attack'),
      defense: _statValue(stats, 'defense'),
      spAtk: _statValue(stats, 'special-attack'),
      spDef: _statValue(stats, 'special-defense'),
      speed: _statValue(stats, 'speed'),
    );

    // --- Moves
    final moves = (response['moves'] as List<dynamic>?)
        ?.map((m) {
          final moveName = m['move']?['name'] as String?;
          final moveId = m['move']?['url']?.toString();
          final versionGroupDetails =
              (m['version_group_details'] as List<dynamic>);
          if (versionGroupDetails.isEmpty || versionGroupDetails[0] == null) {
            return PKMNMoveModel(
              name: moveName,
              moveId: moveId,
              learnMethod: PKMNMoveLearnMethod.unknown,
            );
          }

          final firstDetails =
              versionGroupDetails.first as Map<String, dynamic>;

          final mlm =
              firstDetails['move_learn_method'] as Map<String, dynamic>?;

          if (mlm == null) {
            return PKMNMoveModel(
              name: moveName,
              moveId: moveId,
              learnMethod: PKMNMoveLearnMethod.unknown,
            );
          }

          return PKMNMoveModel(
            name: moveName,
            moveId: moveId,
            learnMethod: _mapLearnMethod(mlm['name'] as String?),
          );
        })
        .whereType<PKMNMoveModel>()
        .toList();

    return PokemonDetailPageModel(
      pkmnId: id,
      pkmnName: name,
      pkmnTypes: types,
      pkmnArtUrl: artUrl,
      pkmnAbout: about,
      pkmnBaseStats: baseStats,
      pkmnMoves: moves,
      pkmnSpeciesName: speciesName,
    );
  }

  // --- Helpers ---

  static int? _statValue(List<dynamic>? stats, String name) {
    return stats?.firstWhere(
      (s) => s['stat']?['name'] == name,
      orElse: () => null,
    )?['base_stat'] as int?;
  }

  static PKMNMoveLearnMethod _mapLearnMethod(String? method) {
    switch (method) {
      case 'level-up':
        return PKMNMoveLearnMethod.levelUp;
      case 'egg':
        return PKMNMoveLearnMethod.egg;
      case 'tutor':
        return PKMNMoveLearnMethod.tutor;
      case 'machine':
        return PKMNMoveLearnMethod.machine;
      default:
        return PKMNMoveLearnMethod.unknown;
    }
  }

  String? _formatHeight(int? dm) {
    if (dm == null) return null;
    final meters = dm / 10.0;
    final totalInches = (meters * 39.3701).round();
    final feet = totalInches ~/ 12;
    final inches = totalInches % 12;
    return "${feet}\' ${inches}\""; // e.g. 3' 11"
  }

  String? _formatWeight(int? hg) {
    if (hg == null) return null;
    final kg = hg / 10.0;
    final lbs = kg * 2.20462;
    return "${lbs.toStringAsFixed(1)} lbs"; // e.g. 8.8 lbs
  }

  // Find the node in the evolution chain whose species.name == target
  Map<String, dynamic>? _findNode(Map<String, dynamic> node, String target) {
    final nName = node['species']?['name'] as String?;
    if (nName != null && nName.toLowerCase() == target.toLowerCase()) {
      return node;
    }
    final children = node['evolves_to'] as List<dynamic>? ?? const [];
    for (final child in children) {
      final found = _findNode(child as Map<String, dynamic>, target);
      if (found != null) return found;
    }
    return null;
  }

  // Collect all species names in the subtree of node.evolves_to
  void _collectForward(Map<String, dynamic> node, List<String> out) {
    final children = node['evolves_to'] as List<dynamic>? ?? const [];
    for (final child in children) {
      final c = child as Map<String, dynamic>;
      final name = c['species']?['name'] as String?;
      if (name != null && name.isNotEmpty) {
        out.add(name);
      }
      // Recurse to capture multi-stage evolutions (e.g., Charmander → Charmeleon → Charizard)
      _collectForward(c, out);
    }
  }

  int? _lastNumberInUrl(String url) {
    final match = RegExp(r'/(\d+)/?$').firstMatch(url);
    return match != null ? int.tryParse(match.group(1)!) : null;
  }

  Future<PokemonDetailEvoModel?> _hydrate(String name) async {
    try {
      final p = await apiClient.get('/pokemon/$name') as Map<String, dynamic>;

      final types = (p['types'] as List<dynamic>?)
              ?.map((t) => mapTypeNameToEnum(
                  (t['type']?['name'] as String?) ?? 'unknown'))
              .toList() ??
          const <PKMNTypes>[];

      final artUrl = p['sprites']?['other']?['official-artwork']
          ?['front_default'] as String?;

      return PokemonDetailEvoModel(
        pkmnName: p['name'] as String?,
        pkmnTypes: types,
        pkmnImageUrl: artUrl,
      );
    } catch (_) {
      return null;
    }
  }
}
