import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/model/pokemon_list_card_model.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_color_theme.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_text.dart';
import 'package:flutter_pokedex/src/shared/utils.dart';
import 'package:flutter_pokedex/src/shared/widgets/pkmn_type_pill.dart';

const double _spriteSize = 72;
const double _cardRadius = 12;
const double _pad = 12;

class PokemonListCard extends StatelessWidget {
  const PokemonListCard({super.key, required this.data, this.onTap});

  final PokemonListCardModel data;
  final VoidCallback? onTap;

  Color get _bg => pkmnType2BgColor((data.pkmnTypes ?? []).firstOrNull);
  Color get _fg => pkmnType2FgColor((data.pkmnTypes ?? []).firstOrNull);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(_cardRadius),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_cardRadius),
        child: Container(
          color: _bg,
          // Height comes from GridView.mainAxisExtent; otherwise wrap with SizedBox(height: 136)
          child: Stack(
            children: [
              // sprite bottom-right in a fixed box
              if (data.imageUrl != null)
                Positioned(
                  right: _pad,
                  bottom: _pad,
                  child: SizedBox(
                    width: _spriteSize,
                    height: _spriteSize,
                    child: Image.network(
                      data.imageUrl!,
                      fit: BoxFit.contain,
                      loadingBuilder: (c, child, p) => p == null
                          ? child
                          : const Center(
                              child: SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2))),
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    ),
                  ),
                ),

              // name top-left (can overlap sprite)
              Positioned(
                left: _pad,
                top: _pad,
                right: _pad, // allow text to flow; it may overlap image
                child: Text(
                  (data.name ?? 'Unknown').capitalise,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: PKMNText.subtitle.textLight,
                ),
              ),

              // types bottom-left; Wrap keeps height stable
              Positioned(
                left: _pad,
                top: _pad + 32,
                right: _pad +
                    _spriteSize +
                    _pad, // avoid pills under sprite; keep these readable
                child: Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: (data.pkmnTypes ?? [])
                      .map((t) => PKMNTypePill(pkmnType: t, cardFgColor: _fg))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PokemonListCardLoading extends StatelessWidget {
  const PokemonListCardLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PKMNColors.skeletonBg,
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
                    Container(
                      decoration: BoxDecoration(
                        color: PKMNColors.skeletonFg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 70,
                      height: 20,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: PKMNColors.skeletonFg,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      width: 50,
                      height: 20,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: PKMNColors.skeletonFg,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      width: 50,
                      height: 20,
                    ),
                  ],
                ),
                // Sprite
                const SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: PKMNColors.skeletonFg,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    width: 80,
                    height: 80,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
