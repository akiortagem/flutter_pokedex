import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/core/routing/path_pattern.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_about_model.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_base_stats_model.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_moves_model.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_page_model.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/view/widgets/pkmn_detail_tabs.dart';
import 'package:flutter_pokedex/src/shared/enums/pkmn_types.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_color_theme.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_text.dart';
import 'package:flutter_pokedex/src/shared/utils.dart';
import 'package:flutter_pokedex/src/shared/widgets/pkmn_type_pill.dart';

// Slicing purpose
const data = PokemonDetailPageModel(
    pkmnId: 123,
    pkmnName: 'Charizard',
    pkmnTypes: [
      PKMNTypes.flying,
      PKMNTypes.dark,
    ],
    pkmnArtUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/'
        'sprites/pokemon/other/official-artwork/132.png',
    pkmnAbout: PokemonDetailAboutModel(
      species: 'Seed',
      height: '2\'3.6" (0.70 cm)',
      weight: '15.2 lbs (6.9 kg)',
      abilities: 'Overgrow, Chlorophyl',
    ),
    pkmnBaseStats: PokemonDetailBaseStatsModel(
      hp: 42,
      attack: 60,
      defense: 15,
      spAtk: 78,
      spDef: 90,
      speed: 100,
    ),
    pkmnMoves: [
      PKMNMoveModel(
        name: 'Scratch',
        moveId: '1',
        learnMethod: PKMNMoveLearnMethod.levelUp,
      ),
      PKMNMoveModel(
        name: 'Extrasensory',
        moveId: '1',
        learnMethod: PKMNMoveLearnMethod.levelUp,
      ),
      PKMNMoveModel(
        name: 'Scratch',
        moveId: '1',
        learnMethod: PKMNMoveLearnMethod.levelUp,
      ),
      PKMNMoveModel(
        name: 'Catasthropika',
        moveId: '1',
        learnMethod: PKMNMoveLearnMethod.levelUp,
      ),
      PKMNMoveModel(
        name: 'Synchronoise',
        moveId: '1',
        learnMethod: PKMNMoveLearnMethod.levelUp,
      ),
      PKMNMoveModel(
        name: 'Ember',
        moveId: '1',
        learnMethod: PKMNMoveLearnMethod.levelUp,
      ),
      PKMNMoveModel(
        name: 'Scratch',
        moveId: '1',
        learnMethod: PKMNMoveLearnMethod.levelUp,
      ),
      PKMNMoveModel(
        name: 'Ember',
        moveId: '1',
        learnMethod: PKMNMoveLearnMethod.levelUp,
      ),
      PKMNMoveModel(
        name: 'Scratch',
        moveId: '1',
        learnMethod: PKMNMoveLearnMethod.levelUp,
      ),
      PKMNMoveModel(
        name: 'Ember',
        moveId: '1',
        learnMethod: PKMNMoveLearnMethod.levelUp,
      ),
      PKMNMoveModel(
        name: 'Scratch',
        moveId: '1',
        learnMethod: PKMNMoveLearnMethod.levelUp,
      ),
      PKMNMoveModel(
        name: 'Ember',
        moveId: '1',
        learnMethod: PKMNMoveLearnMethod.levelUp,
      ),
      PKMNMoveModel(
        name: 'Scratch',
        moveId: '1',
        learnMethod: PKMNMoveLearnMethod.levelUp,
      ),
      PKMNMoveModel(
        name: 'Ember',
        moveId: '1',
        learnMethod: PKMNMoveLearnMethod.levelUp,
      ),
    ]);

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({
    super.key,
    required this.pokemonName,
  });

  // Pattern with a param, not a concrete path:
  static const routePattern = '/pokemon/:pokemonName';
  static final pattern = PathPattern(routePattern);

  // Reverse URL helper:
  static String routeOf(String pokemonName) =>
      pattern.build({'pokemonName': pokemonName});

  final String pokemonName;

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          ((data.pkmnTypes ?? []).firstOrNull ?? PKMNTypes.normal).bgColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Metadata
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Name and type
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.pkmnName ?? 'Unknown',
                          style: PKMNText.title.textLight,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            ...(data.pkmnTypes ?? []).expand((ptype) => [
                                  PKMNTypePill(
                                    pkmnType: ptype,
                                    cardFgColor:
                                        ((data.pkmnTypes ?? []).firstOrNull ??
                                                PKMNTypes.normal)
                                            .fgColor,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  )
                                ])
                          ],
                        ),
                      ],
                    ),
                    Text(
                      '#${(data.pkmnId ?? 0).toString().padLeft(4, '0')}',
                      style: PKMNText.subtitle.textLight.bold,
                    )
                  ],
                ),
              ),
              if (data.pkmnArtUrl != null)
                Center(
                  child: Image.network(data.pkmnArtUrl!, height: 200,
                      loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return SizedBox(
                      height: 200,
                      child: CircularProgressIndicator(
                        color: ((data.pkmnTypes ?? []).firstOrNull ??
                                PKMNTypes.normal)
                            .fgColor,
                      ),
                    );
                  }),
                ),
              Container(
                decoration: const BoxDecoration(
                  color: PKMNColors.textLight,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                height: 350,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 32, 8, 16),
                  child: PKMNDetailTabs(
                    activeTabIndicatorColor:
                        ((data.pkmnTypes ?? []).firstOrNull ?? PKMNTypes.normal)
                            .bgColor,
                    pkmnDetails: data,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
