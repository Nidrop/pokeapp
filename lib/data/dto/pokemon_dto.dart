import 'package:json_annotation/json_annotation.dart';
import 'package:pokeapp/data/dto/pokemon_sprites_dto.dart';
import 'package:pokeapp/data/dto/pokemon_types_dto.dart';

part 'pokemon_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class PokemonDto {
  int id;
  String name;
  int height;
  int weight;
  PokemonSpritesDto sprites;
  List<PokemonTypesDto> types;

  PokemonDto({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.sprites,
    required this.types,
  });

  factory PokemonDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonDtoToJson(this);
}
