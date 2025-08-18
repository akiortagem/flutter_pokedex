import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/data/pkmn_details_ds.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_evo_model.dart';

class PKMNDetailsEvoState {
  const PKMNDetailsEvoState({
    this.isLoading = false,
    this.isError = false,
    this.data,
  });

  final bool isLoading;
  final bool isError;
  final List<PokemonDetailEvoModel>? data;
}

class PKMNDetailsEvoViewModel extends ChangeNotifier {
  PKMNDetailsEvoViewModel(
      {required PKMNDetailsEvoState initial, required this.ds})
      : _state = initial;
  PKMNDetailsEvoState _state;

  final PKMNDetailsDataSource ds;

  PKMNDetailsEvoState get state => _state;

  Future<void> loadInitial(String pkmnName) async {
    _state = const PKMNDetailsEvoState(isLoading: true);
    notifyListeners();

    late List<PokemonDetailEvoModel> data;
    try {
      data = await ds.getPokemonEvoChain(pkmnName);
    } catch (_) {
      _state = const PKMNDetailsEvoState(
        isLoading: false,
        isError: true,
      );
      notifyListeners();
    }

    _state = PKMNDetailsEvoState(
      isLoading: false,
      isError: false,
      data: data,
    );
    notifyListeners();
  }
}
