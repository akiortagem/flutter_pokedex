import 'package:flutter/material.dart';
import 'package:flutter_pokedex/src/features/pokemon_detail/model/pokemon_detail_moves_model.dart';

class PKMNMovesFilterState {
  const PKMNMovesFilterState({
    required this.allMoves,
    required this.currentMoves,
    required this.activeFilters,
  });

  final List<PKMNMoveModel> allMoves;
  final List<PKMNMoveModel> currentMoves;
  final List<PKMNMoveLearnMethod> activeFilters;
}

class PkmnMovesFilterViewModel extends ChangeNotifier {
  PkmnMovesFilterViewModel({
    required PKMNMovesFilterState initial,
  }) : _state = initial;

  PKMNMovesFilterState _state;

  PKMNMovesFilterState get state => _state;

  List<PKMNMoveModel> _buildNewCurrentMoves(List<PKMNMoveLearnMethod> filters) {
    return _state.allMoves.where((m) {
      return filters.contains(m.learnMethod);
    }).toList();
  }

  void addFilter(PKMNMoveLearnMethod filter) {
    if (_state.activeFilters.contains(filter)) {
      return;
    }
    final newFilters = [..._state.activeFilters];
    newFilters.add(filter);

    _state = PKMNMovesFilterState(
      allMoves: _state.allMoves,
      currentMoves: _buildNewCurrentMoves(newFilters),
      activeFilters: newFilters,
    );

    notifyListeners();
  }

  void removeFilter(PKMNMoveLearnMethod filter) {
    if (!_state.activeFilters.contains(filter)) {
      return;
    }
    final newFilters = [
      ..._state.activeFilters.where((f) => f != filter).toList()
    ];

    _state = PKMNMovesFilterState(
      allMoves: _state.allMoves,
      currentMoves: _buildNewCurrentMoves(newFilters),
      activeFilters: newFilters,
    );
    notifyListeners();
  }
}
