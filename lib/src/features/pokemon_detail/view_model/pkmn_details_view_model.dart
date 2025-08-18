import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/data/pkmn_details_ds.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/'
    'pokemon_detail_page_model.dart';

class PKMNDetailsState {
  const PKMNDetailsState({
    this.isLoading = false,
    this.isError = false,
    this.data,
  });
  final bool isLoading;
  final bool isError;
  final PokemonDetailPageModel? data;
}

class PKMNDetailsViewModel extends ChangeNotifier {
  PKMNDetailsViewModel({
    required PKMNDetailsState initial,
    required this.ds,
  }) : _state = initial;

  PKMNDetailsState _state;

  final PKMNDetailsDataSource ds;

  PKMNDetailsState get state => _state;

  Future<void> loadInitial(String pkmnName) async {
    _state = const PKMNDetailsState(isLoading: true);
    notifyListeners();

    late PokemonDetailPageModel data;
    try {
      data = await ds.getPokemonDetails(pkmnName);
    } catch (_) {
      _state = const PKMNDetailsState(
        isLoading: false,
        isError: true,
      );
      notifyListeners();
      return;
    }

    _state = PKMNDetailsState(
      isLoading: false,
      isError: false,
      data: data,
    );
    notifyListeners();
  }
}
