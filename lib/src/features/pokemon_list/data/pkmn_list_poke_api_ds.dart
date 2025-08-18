import 'package:flutter_pokedex/src/core/services/poke_api_client.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/data/'
    'pkmn_list_ds.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/model/'
    'pokemon_list_card_model.dart';
import 'package:flutter_pokedex/src/shared/enums/pkmn_types.dart';

class PKMNListPokeAPIDataSource implements PKMNListDataSource {
  const PKMNListPokeAPIDataSource({
    required this.apiClient,
  });

  final PokeApiClient apiClient;

  int? _extractIdFromUrl(String url) {
    // Example: https://pokeapi.co/api/v2/pokemon/6/
    final match = RegExp(r'/pokemon/(\d+)/?$').firstMatch(url);
    if (match == null) return null;
    return int.tryParse(match.group(1)!);
  }

  @override
  Future<List<PokemonListCardModel>> getPokemonList({
    int? offset,
    int? limit,
  }) async {
    final response = await apiClient.get('/pokemon', query: {
      'offset': (offset ?? 0).toString(),
      'limit': (limit ?? 20).toString(),
    });
    final List<dynamic> results =
        (response as Map<String, dynamic>)['results'] as List<dynamic>;

    // 2) Concurrently fetch details for each pokemon, map to our model
    //    PokeAPI default page size is 20 — safe to fetch in parallel.
    final models = await Future.wait(
      results.map<Future<PokemonListCardModel>>((item) async {
        final String name = item['name'] as String? ?? '';
        final String url = item['url'] as String? ?? '';

        final int? id = _extractIdFromUrl(url);
        // Detail fetch: use id if we have it; else fall back to name path.
        final detail = await apiClient.get('/pokemon/${id ?? name}');

        // Types → List<PKMNTypes>
        final List<dynamic> typesJson = (detail['types'] as List?) ?? const [];
        final List<PKMNTypes> types = typesJson
            .map((t) => (t['type']?['name'] as String?) ?? '')
            .map(mapTypeNameToEnum)
            .cast<PKMNTypes>()
            .toList();

        // Official artwork URL — prefer detail sprite; fall back to predictable CDN path
        final String? spriteFromDetail = detail['sprites']?['other']
            ?['official-artwork']?['front_default'] as String?;

        return PokemonListCardModel(
          name: name,
          pkmnTypes: types,
          imageUrl: spriteFromDetail,
        );
      }),
    );

    return models;
  }
}
