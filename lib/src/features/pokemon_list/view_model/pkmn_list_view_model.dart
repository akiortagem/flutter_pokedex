import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/data/pkmn_list_ds.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/model/pokemon_list_card_model.dart';

class PKMNListState {
  const PKMNListState({
    this.isLoading = false,
    this.pkmnList,
  });

  final bool isLoading;
  final List<PokemonListCardModel>? pkmnList;
}

class PKMNListViewModel extends ChangeNotifier {
  PKMNListViewModel({
    required PKMNListState initial,
    required this.ds,
  }) : _state = initial;

  PKMNListState _state;

  final PKMNListDataSource ds;

  PKMNListState get state => _state;

  Future<void> loadInit() async {
    _state = const PKMNListState(
      isLoading: true,
    );
    notifyListeners();

    final data = await ds.getPokemonList();

    _state = PKMNListState(
      isLoading: false,
      pkmnList: data,
    );
  }
}
