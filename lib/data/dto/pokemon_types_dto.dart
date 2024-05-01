import 'package:json_annotation/json_annotation.dart';
import 'package:pokeapp/data/dto/pokemon_types_type_dto.dart';

part 'pokemon_types_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class PokemonTypesDto {
  int slot;
  PokemonTypesTypeDto type;

  PokemonTypesDto({
    required this.slot,
    required this.type,
  });

  factory PokemonTypesDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonTypesDtoToJson(this);
}
