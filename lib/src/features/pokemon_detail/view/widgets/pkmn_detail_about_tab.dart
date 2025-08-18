import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_about_model.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_text.dart';
import 'package:flutter_pokedex/src/shared/utils.dart';

class PKMNDetailAboutTab extends StatelessWidget {
  const PKMNDetailAboutTab({
    super.key,
    required this.pkmnAboutData,
  });

  final PokemonDetailAboutModel pkmnAboutData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PKMNStringDataEntry(
            label: 'Species',
            data: (pkmnAboutData.species ?? 'NO DATA').capitalise,
          ),
          const SizedBox(height: 16),
          _PKMNStringDataEntry(
            label: 'Height',
            data: pkmnAboutData.height ?? 'NO DATA',
          ),
          const SizedBox(height: 16),
          _PKMNStringDataEntry(
            label: 'Weight',
            data: pkmnAboutData.weight ?? 'NO DATA',
          ),
          const SizedBox(height: 16),
          _PKMNStringDataEntry(
            label: 'Abilities',
            data: pkmnAboutData.abilities == null
                ? 'NO DATA'
                : pkmnAboutData.abilities!
                    .split(', ')
                    .map((a) => a.dashToCapitalized)
                    .join(', '),
          ),
        ],
      ),
    );
  }
}

class _PKMNStringDataEntry extends StatelessWidget {
  const _PKMNStringDataEntry({
    required this.label,
    required this.data,
  });

  final String label;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: PKMNText.bodyText1.textSecondary.bold.large,
          ),
        ),
        Expanded(
          child: Text(
            data,
            style: PKMNText.bodyText1.bold.large,
            textAlign: TextAlign.start,
          ),
        )
      ],
    );
  }
}
