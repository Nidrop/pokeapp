import 'package:pokeapp/domain/model/pokemon.dart';
import 'package:pokeapp/domain/model/pokemon_list.dart';

abstract class PokemonRepository {
  Future<PokemonList> getList();
  Future<PokemonList> getListNext();
  Future<PokemonList> getListPrevious();
  Future<Pokemon> getPokemon(String name);
}
