import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_base_stats_model.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_color_theme.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_text.dart';

// Apparently there's no concrete agreement between fans on what's the max value
// of a pokemon's stat, so I'll just make it 255 for now
const statMaxLimit = 255;

class PKMNDetailBaseStatsTab extends StatelessWidget {
  const PKMNDetailBaseStatsTab({
    super.key,
    required this.pkmnBaseStats,
  });

  final PokemonDetailBaseStatsModel pkmnBaseStats;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PKMNIntGageDataEntry(
            label: 'HP',
            data: pkmnBaseStats.hp,
          ),
          const SizedBox(height: 16),
          _PKMNIntGageDataEntry(
            label: 'Attack',
            data: pkmnBaseStats.attack,
          ),
          const SizedBox(height: 16),
          _PKMNIntGageDataEntry(
            label: 'Defense',
            data: pkmnBaseStats.defense,
          ),
          const SizedBox(height: 16),
          _PKMNIntGageDataEntry(
            label: 'Sp. Atk',
            data: pkmnBaseStats.spAtk,
          ),
          const SizedBox(height: 16),
          _PKMNIntGageDataEntry(
            label: 'Sp. Def',
            data: pkmnBaseStats.spDef,
          ),
          const SizedBox(height: 16),
          _PKMNIntGageDataEntry(
            label: 'Speed',
            data: pkmnBaseStats.speed,
          ),
        ],
      ),
    );
  }
}

class _PKMNIntGageDataEntry extends StatelessWidget {
  const _PKMNIntGageDataEntry({
    required this.label,
    this.data,
    this.max, //  keep this around so I can override it later
  });

  final String label;
  final int? data;
  final int? max;

  @override
  Widget build(BuildContext context) {
    // Calculates max gauge length for each stat
    final actualMax = max ?? ((data ?? 0) < 100 ? 100 : statMaxLimit);
    final ratio = ((data ?? 0) / actualMax).clamp(0.0, 1.0);

    return Row(
      children: [
        // left label
        SizedBox(
          width: 75, // keep columns aligned
          child: Text(
            label,
            style: PKMNText.bodyText1.bold.textSecondary.large,
          ),
        ),
        // value
        SizedBox(
          width: 32,
          child: Text(
            data == null ? 'N/A' : data.toString(),
            textAlign: TextAlign.right,
            style: PKMNText.bodyText1.bold.large,
          ),
        ),
        const SizedBox(width: 8),
        // progress bar
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: 8,
              child: Stack(
                children: [
                  // baseline
                  Container(color: Colors.black12),
                  // fill
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: ratio.toDouble(),
                    child: Container(
                      color: ratio > 0.5
                          ? PKMNColors.pokedexGreen
                          : PKMNColors.pokedexRed,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
