import 'package:json_annotation/json_annotation.dart';

part 'pokemon_types_type_dto.g.dart';

@JsonSerializable()
class PokemonTypesTypeDto {
  String name;
  // String url;

  PokemonTypesTypeDto({
    required this.name,
  });

  factory PokemonTypesTypeDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypesTypeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonTypesTypeDtoToJson(this);
}
