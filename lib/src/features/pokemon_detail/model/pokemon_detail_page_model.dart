import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_about_model.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_base_stats_model.dart';
import 'package:flutter_pokedex/src/shared/enums/pkmn_types.dart';

class PokemonDetailPageModel {
  const PokemonDetailPageModel({
    this.pkmnId,
    this.pkmnName,
    this.pkmnTypes,
    this.pkmnArtUrl,
    this.pkmnAbout,
    this.pkmnBaseStats,
  });

  final List<PKMNTypes>? pkmnTypes;
  final String? pkmnName;
  final int? pkmnId;
  final String? pkmnArtUrl;
  final PokemonDetailAboutModel? pkmnAbout;
  final PokemonDetailBaseStatsModel? pkmnBaseStats;
}
