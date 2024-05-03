import 'package:pokeapp/domain/model/pokemon_list.dart';

enum PokemonListStatus {
  init,
  loading,
  loadMore,
  succesful,
  failure,
}

class PokemonListState {
  final PokemonList list;
  final PokemonListStatus status;

  PokemonListState({
    required this.list,
    required this.status,
  });
}
