import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_moves_model.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/view_model/pkmn_moves_filter_view_model.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_color_theme.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_text.dart';

class PKMNDetailMovesTab extends StatefulWidget {
  const PKMNDetailMovesTab({
    super.key,
    required this.pkmnMoves,
  });

  final List<PKMNMoveModel> pkmnMoves;

  @override
  State<StatefulWidget> createState() => _PKMNDetailMovesTabState();
}

class _PKMNDetailMovesTabState extends State<PKMNDetailMovesTab> {
  late PkmnMovesFilterViewModel filterViewModel;

  @override
  void initState() {
    filterViewModel = PkmnMovesFilterViewModel(
        initial: PKMNMovesFilterState(
      allMoves: widget.pkmnMoves,
      currentMoves: widget.pkmnMoves,
      activeFilters: [],
    ));
    filterViewModel.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 50,
            child: ListView.separated(
              itemCount: PKMNMoveLearnMethod.values.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final lm = PKMNMoveLearnMethod.values[index];
                final active = filterViewModel.state.activeFilters.contains(lm);
                return _PKMNMoveLearnMethodFilter(
                  method: lm,
                  active: active,
                  onTap: (lm) {
                    if (active) {
                      filterViewModel.removeFilter(lm);
                    } else {
                      filterViewModel.addFilter(lm);
                    }
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 5,
                );
              },
            ),
          ),
          SizedBox(
              height: 150,
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 2 columns
                        crossAxisSpacing: 8, // space between columns
                        mainAxisSpacing: 8, // space between rows
                        childAspectRatio: 3 / 2,
                        mainAxisExtent: 35,
                      ),
                      padding: const EdgeInsets.all(8),
                      itemCount: filterViewModel
                          .state.currentMoves.length, // number of items
                      itemBuilder: (context, index) {
                        return _PKMNMoveBox(
                          name:
                              filterViewModel.state.currentMoves[index].name ??
                                  'NO DATA',
                        );
                      },
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class _PKMNMoveBox extends StatelessWidget {
  const _PKMNMoveBox({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 2,
          color: PKMNColors.pokedexBlue,
        ),
      ),
      child: Center(
        child: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: PKMNText.subtitle.small,
        ),
      ),
    );
  }
}

class _PKMNMoveLearnMethodFilter extends StatelessWidget {
  const _PKMNMoveLearnMethodFilter({
    required this.method,
    this.active = false,
    this.onTap,
  });

  final PKMNMoveLearnMethod method;
  final bool active;
  final void Function(PKMNMoveLearnMethod)? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call(method);
      },
      child: Chip(
          backgroundColor:
              active ? PKMNColors.textSecondary : PKMNColors.surface,
          label: Text(
            method.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: PKMNText.subtitle.small.copyWith(
              color: active ? PKMNColors.textLight : PKMNColors.textPrimary,
            ),
          )),
    );
  }
}
