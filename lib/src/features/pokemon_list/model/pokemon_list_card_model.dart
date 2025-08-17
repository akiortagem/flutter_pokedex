import 'package:flutter_pokedex/src/shared/enums/pkmn_types.dart';

class PokemonListCardModel {
  const PokemonListCardModel({
    this.name,
    this.pkmnTypes,
    this.imageUrl,
  });

  final String? name;
  final List<PKMNTypes>? pkmnTypes;
  final String? imageUrl;
}
