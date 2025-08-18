import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_evo_model.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_page_model.dart';

abstract class PKMNDetailsDataSource {
  Future<PokemonDetailPageModel> getPokemonDetails(String pkmnName);
  Future<List<PokemonDetailEvoModel>> getPokemonEvoChain(String pkmnName);
}
