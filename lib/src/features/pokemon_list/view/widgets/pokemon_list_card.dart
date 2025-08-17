import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/model/pokemon_list_card_model.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_text.dart';
import 'package:flutter_pokedex/src/shared/utils.dart';
import 'package:flutter_pokedex/src/shared/widgets/pkmn_type_pill.dart';

class PokemonListCard extends StatelessWidget {
  const PokemonListCard({
    super.key,
    required this.data,
    this.onTap,
    this.width,
  });

  final PokemonListCardModel data;
  final VoidCallback? onTap;
  final double? width;

  Color get cardBgColor {
    return pkmnType2BgColor((data.pkmnTypes ?? []).firstOrNull);
  }

  Color get cardFgColor {
    return pkmnType2FgColor((data.pkmnTypes ?? []).firstOrNull);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap == null) {
          return;
        }
        onTap?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Column(
            children: [
              // Name and types list
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name ?? 'Unknown',
                        style: PKMNText.subtitle.textLight,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ...(data.pkmnTypes ?? []).expand((ptype) => [
                            PKMNTypePill(
                              pkmnType: ptype,
                              cardFgColor: cardFgColor,
                            ),
                            const SizedBox(
                              height: 4,
                            )
                          ])
                    ],
                  ),
                  // Sprite
                  if (data.imageUrl != null) ...[
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(data.imageUrl!, height: 80,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return SizedBox(
                                  height: 80,
                                  child: CircularProgressIndicator(
                                    color: cardFgColor,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
