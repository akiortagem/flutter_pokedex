import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/core/services/poke_api_client.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/view/pokemon_detail_page.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/data/pkmn_list_poke_api_ds.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/model/pokemon_list_card_model.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/view/widgets/pokemon_list_card.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/view_model/pkmn_list_view_model.dart';
import 'package:flutter_pokedex/src/shared/enums/pkmn_types.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_text.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  static const routeName = '/pokemons';

  @override
  State<StatefulWidget> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  late PKMNListViewModel listViewModel;

  @override
  void initState() {
    listViewModel = PKMNListViewModel(
      initial: const PKMNListState(),
      ds: PKMNListPokeAPIDataSource(
        apiClient: PokeApiClient(),
      ),
    );
    listViewModel.addListener(() => setState(() {}));
    listViewModel.loadInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int getItemLength() {
      if (listViewModel.state.isLoading) {
        return 20;
      }
      return (listViewModel.state.pkmnList ?? []).length;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pokedex',
                style: PKMNText.title,
              ),
              const SizedBox(
                height: 24,
              ),
              if (!listViewModel.state.isLoading &&
                  listViewModel.state.pkmnList != null &&
                  listViewModel.state.pkmnList!.isNotEmpty)
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 columns
                      crossAxisSpacing: 8, // space between columns
                      mainAxisSpacing: 8, // space between rows
                      childAspectRatio: 3 / 2,
                      mainAxisExtent: 130,
                    ),
                    padding: const EdgeInsets.all(8),
                    itemCount: getItemLength(), // number of items
                    itemBuilder: (context, index) {
                      final data = listViewModel.state.pkmnList![index];
                      return PokemonListCard(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            PokemonDetailPage.routeOf('charizard'),
                          );
                        },
                        data: data,
                        // data: const PokemonListCardModel(
                        //   name: 'Charizard',
                        //   pkmnTypes: [
                        //     PKMNTypes.fire,
                        //     PKMNTypes.dragon,
                        //   ],
                        //   imageUrl:
                        //       'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/132.png',
                        // ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
