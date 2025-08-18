import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/data/pkmn_list_ds.dart';
import 'package:flutter_pokedex/src/features/pokemon_list/model/pokemon_list_card_model.dart';

class PKMNListState {
  const PKMNListState({
    this.isLoading = false,
    this.isError = false,
    this.pkmnList,
  });

  final bool isLoading;
  final bool isError;
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

    late List<PokemonListCardModel> data;

    try {
      data = await ds.getPokemonList();
    } catch (_) {
      _state = const PKMNListState(
        isLoading: false,
        isError: true,
      );
      notifyListeners();
      return;
    }

    _state = PKMNListState(
      isLoading: false,
      pkmnList: data,
    );
    notifyListeners();
  }
}
