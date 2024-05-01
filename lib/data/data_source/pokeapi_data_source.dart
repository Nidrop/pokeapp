import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:pokeapp/data/dto/pokemon_dto.dart';
import 'package:pokeapp/data/dto/pokemon_list_dto.dart';

part 'pokeapi_data_source.g.dart';

@RestApi(baseUrl: "https://pokeapi.co")
abstract class PokeapiDataSource {
  factory PokeapiDataSource(Dio dio, {String baseUrl}) = _PokeapiDataSource;

  @GET("/api/v2/pokemon")
  Future<PokemonListDto> getList();

  @GET("/api/v2/pokemon?{query}")
  Future<PokemonListDto> getListWithArgs(@Path("query") String query);

  @GET("/api/v2/pokemon/{id}")
  Future<PokemonDto> getPokemon(@Path("id") int id);
}
