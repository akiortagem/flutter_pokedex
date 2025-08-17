import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/view/pokemon_detail_page.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/model/pokemon_list_card_model.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/view/widgets/pokemon_list_card.dart';
import 'package:flutter_pokedex/src/shared/enums/pkmn_types.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_text.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  static const routeName = '/pokemons';

  @override
  State<StatefulWidget> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 columns
                    crossAxisSpacing: 8, // space between columns
                    mainAxisSpacing: 8, // space between rows
                    childAspectRatio: 3 / 2,
                    mainAxisExtent: 130,
                  ),
                  padding: const EdgeInsets.all(8),
                  itemCount: 20, // number of items
                  itemBuilder: (context, index) {
                    return PokemonListCard(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          PokemonDetailPage.routeOf('charizard'),
                        );
                      },
                      data: const PokemonListCardModel(
                        name: 'Charizard',
                        pkmnTypes: [
                          PKMNTypes.fire,
                          PKMNTypes.dragon,
                        ],
                        imageUrl:
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/132.png',
                      ),
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
