import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_page_model.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/view/widgets/pkmn_detail_about_tab.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/view/widgets/pkmn_detail_base_stats_tab.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/view/widgets/pkmn_detail_evo_tab.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/view/widgets/pkmn_detail_moves_tab.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/view/widgets/pkmn_detail_no_data_tab.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_text.dart';

class PKMNDetailTabs extends StatelessWidget {
  const PKMNDetailTabs({
    super.key,
    this.activeTabIndicatorColor,
    this.pkmnDetails,
  });

  final Color? activeTabIndicatorColor;
  final PokemonDetailPageModel? pkmnDetails;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Tab row with a baseline divider behind it
          Stack(
            children: [
              // the faint full-width baseline
              const SizedBox(height: 48), // height of the tab row
              const Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Divider(height: 1, thickness: 1), // light grey line
                ),
              ),
              // the real TabBar on top
              TabBar(
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.black45,
                indicatorSize: TabBarIndicatorSize.label,
                // short underline under active tab
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: activeTabIndicatorColor ?? const Color(0xFF6670C8),
                  ),
                ),
                labelStyle: PKMNText.bodyText1.bold,
                tabs: const [
                  Tab(text: 'About'),
                  Tab(text: 'Base Stats'),
                  Tab(text: 'Evolution'),
                  Tab(text: 'Moves'),
                ],
              ),
            ],
          ),

          // Tab contents
          Expanded(
            child: TabBarView(
              children: [
                pkmnDetails?.pkmnAbout != null
                    ? PKMNDetailAboutTab(
                        pkmnAboutData: pkmnDetails!.pkmnAbout!,
                      )
                    : const PKMNDetailNoDataTab(), // About
                pkmnDetails?.pkmnBaseStats != null
                    ? PKMNDetailBaseStatsTab(
                        pkmnBaseStats: pkmnDetails!.pkmnBaseStats!)
                    : const PKMNDetailNoDataTab(), // Base Stats
                pkmnDetails != null
                    ? PKMNDetailEvoTab(pkmnDetails: pkmnDetails!)
                    : const PKMNDetailNoDataTab(), // Evolution
                pkmnDetails?.pkmnMoves != null
                    ? PKMNDetailMovesTab(
                        pkmnMoves: pkmnDetails!.pkmnMoves!,
                      )
                    : const PKMNDetailNoDataTab(), // Moves
              ],
            ),
          ),
        ],
      ),
    );
  }
}
