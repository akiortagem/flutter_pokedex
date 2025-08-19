import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_pokedex/src/core/services/poke_api_client.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/data/pkmn_details_poke_api_ds.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_page_model.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/view_model/pkmn_details_evo_view_model.dart';
import 'package:flutter_pokedex/src/shared/enums/pkmn_types.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_color_theme.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_icon_constants.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_text.dart';
import 'package:flutter_pokedex/src/shared/utils.dart';
import 'package:flutter_svg/svg.dart';

// This doesn't cover Eeveelutions and Applins yet. . .
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
  late PKMNDetailsEvoViewModel evoViewModel;

  @override
  void initState() {
    evoViewModel = PKMNDetailsEvoViewModel(
      initial: const PKMNDetailsEvoState(),
      ds: PKMNDetailsPokeAPIDataSource(
        apiClient: PokeApiClient(),
      ),
    );
    evoViewModel.addListener(() => setState(() {}));
    evoViewModel.loadInitial(widget.pkmnDetails.pkmnName ?? 'Unknown');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (evoViewModel.state.isError) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'NO DATA',
                style: PKMNText.title,
              ),
              Text(
                'Please contact Prof. Oak for support',
                style: PKMNText.bodyText1.small.italic.textSecondary,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final data = evoViewModel.state.data;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: 500,
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: !evoViewModel.state.isLoading &&
                      evoViewModel.state.data != null
                  ? [
                      for (int i = 0; i < data!.length; i++) ...[
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
                    ]
                  : [
                      const PKMNEvoPicSkeleton(),
                      SvgPicture.asset(
                        PKMNIcons.icArrowRight,
                        width: 20,
                      ),
                      const PKMNEvoPicSkeleton(),
                      SvgPicture.asset(
                        PKMNIcons.icArrowRight,
                        width: 20,
                      ),
                      const PKMNEvoPicSkeleton()
                    ],
            ),
          ),
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

class PKMNEvoPicSkeleton extends StatelessWidget {
  const PKMNEvoPicSkeleton({super.key});

  final double size = 100;

  @override
  Widget build(BuildContext context) {
    final double imgSize = size * 0.8;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Circular placeholder for Pokémon art
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: PKMNColors.skeletonBg,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Container(
              width: imgSize,
              height: imgSize,
              decoration: BoxDecoration(
                color: PKMNColors.skeletonFg,
                borderRadius: BorderRadius.circular(imgSize),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        // Placeholder for Pokémon name
        Container(
          width: 60,
          height: 14,
          decoration: BoxDecoration(
            color: PKMNColors.skeletonFg,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
