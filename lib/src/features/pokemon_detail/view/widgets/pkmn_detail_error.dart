import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_color_theme.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_text.dart';

class PKMNErrorDetail extends StatelessWidget {
  const PKMNErrorDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PKMNColors.skeletonBg,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Metadata (fake header placeholders)
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 24,
                          decoration: BoxDecoration(
                              color: PKMNColors.skeletonFg,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 60,
                          height: 20,
                          decoration: BoxDecoration(
                              color: PKMNColors.skeletonFg,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 20,
                      decoration: BoxDecoration(
                          color: PKMNColors.skeletonFg,
                          borderRadius: BorderRadius.circular(8)),
                    )
                  ],
                ),
              ),

              // Error message instead of Pokémon art
              Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'NO DATA',
                        style: PKMNText.title,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please contact Prof. Oak for support',
                        style: PKMNText.bodyText1.small.italic.textSecondary,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom container to keep visual consistency
              Container(
                decoration: const BoxDecoration(
                  color: PKMNColors.textLight,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                height: 200,
                child: const Center(
                  child: Icon(
                    Icons.error_outline,
                    color: PKMNColors.skeletonFg,
                    size: 48,
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
