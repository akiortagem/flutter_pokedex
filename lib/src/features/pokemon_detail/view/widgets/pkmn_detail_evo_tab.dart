import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_evo_model.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_page_model.dart';
import 'package:flutter_pokedex/src/shared/enums/pkmn_types.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_icon_constants.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_text.dart';
import 'package:flutter_pokedex/src/shared/utils.dart';
import 'package:flutter_svg/svg.dart';

// For slicing purposes
const data = [
  PokemonDetailEvoModel(
    pkmnName: 'Charmander',
    pkmnTypes: [PKMNTypes.fire],
    pkmnImageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/'
        'sprites/pokemon/other/official-artwork/132.png',
  ),
  PokemonDetailEvoModel(
    pkmnName: 'Charizard',
    pkmnTypes: [PKMNTypes.ghost, PKMNTypes.dragon],
    pkmnImageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/'
        'sprites/pokemon/other/official-artwork/132.png',
  ),
];

class PKMNDetailEvoTab extends StatefulWidget {
  const PKMNDetailEvoTab({
    super.key,
    required this.pkmnDetails,
  });

  final PokemonDetailPageModel pkmnDetails;

  @override
  State<StatefulWidget> createState() => _PKMNDetailEvoTabState();
}

class _PKMNDetailEvoTabState extends State<PKMNDetailEvoTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < data.length; i++) ...[
              _PKMNEvoPic(
                pkmnImageUrl: data[i].pkmnImageUrl,
                pkmnTypes: data[i].pkmnTypes,
                pkmnName: data[i].pkmnName,
              ),
              if (i < data.length - 1)
                SvgPicture.asset(
                  PKMNIcons.icArrowRight,
                  width: 20,
                ),
            ]
          ],
        ),
      ),
    );
  }
}

class _PKMNEvoPic extends StatelessWidget {
  const _PKMNEvoPic({
    this.pkmnImageUrl,
    this.pkmnTypes,
    this.pkmnName,
  });

  final String? pkmnImageUrl;
  final List<PKMNTypes>? pkmnTypes;
  final String? pkmnName;

  Color get bgColor => pkmnType2BgColor((pkmnTypes ?? []).firstOrNull);
  Color get fgColor => pkmnType2FgColor((pkmnTypes ?? []).firstOrNull);

  final double size = 100;

  @override
  Widget build(BuildContext context) {
    final double imgSize = size * 0.8;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(100),
          ),
          width: size,
          height: size,
          child: Center(
            child: pkmnImageUrl != null
                ? Image.network(pkmnImageUrl!, width: imgSize, height: imgSize,
                    loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return SizedBox(
                      width: imgSize,
                      height: imgSize,
                      child: CircularProgressIndicator(
                        color: fgColor,
                      ),
                    );
                  })
                : Text(
                    'NO DATA',
                    style: PKMNText.title.copyWith(color: fgColor),
                  ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          pkmnName ?? 'Unknown',
          style: PKMNText.subtitle,
        )
      ],
    );
  }
}
