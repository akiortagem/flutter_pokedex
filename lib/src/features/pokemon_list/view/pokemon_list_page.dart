import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/core/services/poke_api_client.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/view/pokemon_detail_page.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/data/pkmn_list_poke_api_ds.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/view/widgets/pokemon_list_card.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/view_model/pkmn_list_view_model.dart';
import 'package:flutter_pokedex/src/shared/themes/pkmn_text.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  static const routeName = '/pokemons';

  @override
  State<StatefulWidget> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  late PKMNListViewModel listViewModel;
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();

    listViewModel = PKMNListViewModel(
      initial: const PKMNListState(),
      ds: PKMNListPokeAPIDataSource(apiClient: PokeApiClient()),
    );

    listViewModel.addListener(() => setState(() {}));
    listViewModel.loadInit();

    _scroll.addListener(_onScroll);
  }

  void _onScroll() {
    // Trigger when we're within ~300px of the bottom
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 300) {
      listViewModel.loadMore();
    }
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    listViewModel.dispose();
    super.dispose();
  }

  int _itemCount() {
    if (listViewModel.state.isLoading) return 20; // initial skeletons
    final base = (listViewModel.state.pkmnList ?? []).length;
    final extra = listViewModel.state.isLoadingMore ? 1 : 0; // loader tile
    return base + extra;
  }

  bool _isLoaderTile(int index) {
    if (listViewModel.state.isLoading) return false;
    final len = (listViewModel.state.pkmnList ?? []).length;
    return listViewModel.state.isLoadingMore && index == len;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pokedex', style: PKMNText.title),
              const SizedBox(height: 24),
              if (listViewModel.state.isError)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('ERROR', style: PKMNText.title),
                        Text(
                          'Please contact Prof. Oak for support',
                          style: PKMNText.bodyText1.small.italic.textSecondary,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              if (!listViewModel.state.isError)
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await listViewModel.refresh();
                    },
                    child: GridView.builder(
                      controller: _scroll,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 3 / 2,
                        mainAxisExtent: 130,
                      ),
                      padding: const EdgeInsets.all(8),
                      itemCount: _itemCount(),
                      itemBuilder: (context, index) {
                        // Initial page skeletons
                        if (listViewModel.state.isLoading) {
                          return const PokemonListCardLoading();
                        }

                        // The loader tile at the end during pagination
                        if (_isLoaderTile(index)) {
                          return const PokemonListCardLoading();
                        }

                        // Normal items
                        final data = listViewModel.state.pkmnList![index];
                        return PokemonListCard(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              PokemonDetailPage.routeOf(data.name ?? ''),
                            );
                          },
                          data: data,
                        );
                      },
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
