import 'package:pokeapp/data/dto/pokemon_dto.dart';
import 'package:pokeapp/domain/model/pokemon.dart';

extension PokemonMapper on PokemonDto {
  Pokemon toModel() => Pokemon(
        name: name,
        imagePath: sprites.front_default,
        height: height * 10,
        weight: weight / 10,
        types: [for (final e in types) e.type.name],
      );
}
