import 'package:pokeapp/data/dto/pokemon_list_dto.dart';
import 'package:pokeapp/domain/model/pokemon_list.dart';

extension PokemonListMapper on PokemonListDto {
  PokemonList toModel() => PokemonList(
        count: count,
        next: next,
        previous: previous,
        names: [for (final e in results) e.name],
      );
}
