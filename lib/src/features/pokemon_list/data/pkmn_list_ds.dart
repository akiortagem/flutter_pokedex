import 'package:flutter_pokedex/src/features/pokemon_list/model/pokemon_list_card_model.dart';

abstract class PKMNListDataSource {
  Future<List<PokemonListCardModel>> getPokemonList({
    int? offset,
    int? limit,
  });
}
