import 'package:flutter_pokedex/src/shared/enums/pkmn_types.dart';

class PokemonDetailEvoModel {
  const PokemonDetailEvoModel({
    this.pkmnName,
    this.pkmnTypes,
    this.pkmnImageUrl,
  });

  final String? pkmnName;
  final List<PKMNTypes>? pkmnTypes;
  final String? pkmnImageUrl;
}
