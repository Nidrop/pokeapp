import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pokeapp/data/data_source/pokeapi_data_source.dart';
import 'package:pokeapp/data/dto/mappers/pokemon_list_mapper.dart';
import 'package:pokeapp/data/dto/mappers/pokemon_mapper.dart';
import 'package:pokeapp/data/dto/pokemon_dto.dart';
import 'package:pokeapp/data/dto/pokemon_list_dto.dart';
import 'package:pokeapp/domain/model/pokemon.dart';
import 'package:pokeapp/domain/model/pokemon_list.dart';
import 'package:pokeapp/domain/repository/pokemon_repository.dart';

class PokeapiRepository implements PokemonRepository {
  final PokeapiDataSource _source;
  String? next;
  String? previous;

  PokeapiRepository(this._source);

  @override
  Future<PokemonList> getList({bool skipCache = false}) async {
    // TODO refactor
    try {
      PokemonListDto listDto;
      if (skipCache) {
        listDto = await _source.getList();
      } else {
        final cm = DefaultCacheManager();
        const cacheUrl = 'pokeapi';
        final listDtoFileInfo = await cm.getFileFromCache(cacheUrl);
        File listDtoFile;
        if (listDtoFileInfo == null) {
          final listDto = await _source.getList();
          //omg
          final jsonString = jsonEncode(listDto);
          listDtoFile = await cm.putFile(
              cacheUrl, Uint8List.fromList(utf8.encode(jsonString)));
          debugPrint('put in cache');
        } else {
          listDtoFile = listDtoFileInfo.file;
          debugPrint('cache is available');
        }
        //omg
        final jsonString =
            String.fromCharCodes(await listDtoFile.readAsBytes());
        listDto = PokemonListDto.fromJson(jsonDecode(jsonString));
        debugPrint('retrived from cache');
      }

      final result = listDto.toModel();
      next = result.next;
      previous = result.previous;
      return result;
    } on DioException catch (e) {
      String err =
          "Dio exception handler: ${e.message ?? 'e.message is null'}; ${e.stackTrace}";
      debugPrint(err);
      return Future.error(Exception(err));
      // } on FormatException catch (e) {
      //   String err = "Format exception handler: ${e.message}";
      //   debugPrint(err);
      //   return Future.error(Exception(err));
    }
  }

  @override
  Future<PokemonList> getListNext({bool skipCache = false}) async {
    if (next == null) {
      return Future.error(Exception('next is null'));
      // return getList();
    }
    String args = '';
    try {
      args = next!.split('?')[1];
    } catch (e) {
      return Future.error(Exception('invalid url arguments'));
    }

    try {
      PokemonListDto listDto;
      if (skipCache) {
        listDto = await _source.getListWithArgs(args);
      } else {
        final cm = DefaultCacheManager();
        final cacheUrl = 'pokeapi?$args';
        final listDtoFileInfo = await cm.getFileFromCache(cacheUrl);
        File listDtoFile;
        if (listDtoFileInfo == null) {
          final listDto = await _source.getListWithArgs(args);
          //omg
          final jsonString = jsonEncode(listDto);
          listDtoFile = await cm.putFile(
              cacheUrl, Uint8List.fromList(utf8.encode(jsonString)));
          debugPrint('put in cache');
        } else {
          listDtoFile = listDtoFileInfo.file;
          debugPrint('cache is available');
        }
        //omg
        final jsonString =
            String.fromCharCodes(await listDtoFile.readAsBytes());
        listDto = PokemonListDto.fromJson(jsonDecode(jsonString));
        debugPrint('retrived from cache');
      }

      final result = listDto.toModel();
      next = result.next;
      previous = result.previous;
      return result;
    } on DioException catch (e) {
      String err = "Dio exception handler: ${e.message ?? 'e.message is null'}";
      debugPrint(err);
      return Future.error(Exception(err));
    } on FormatException catch (e) {
      String err = "Format exception handler: ${e.message}";
      debugPrint(err);
      return Future.error(Exception(err));
    }
  }

  @override
  Future<PokemonList> getListPrevious() {
    // TODO: implement getListPrevious
    throw UnimplementedError();
  }

  @override
  Future<Pokemon> getPokemon(String name, {bool skipCache = false}) async {
    try {
      PokemonDto pokemonDto;
      if (skipCache) {
        pokemonDto = await _source.getPokemon(name);
      } else {
        final cm = DefaultCacheManager();
        final cacheUrl = 'pokeapi/$name';
        final pokemonDtoFileInfo = await cm.getFileFromCache(cacheUrl);
        File pokemonDtoFile;
        if (pokemonDtoFileInfo == null) {
          final pokemonDto = await _source.getPokemon(name);
          //omg
          final jsonString = jsonEncode(pokemonDto);
          pokemonDtoFile = await cm.putFile(
              cacheUrl, Uint8List.fromList(utf8.encode(jsonString)));
          debugPrint('put in cache');
        } else {
          pokemonDtoFile = pokemonDtoFileInfo.file;
          debugPrint('cache is available');
        }
        //omg
        final jsonString =
            String.fromCharCodes(await pokemonDtoFile.readAsBytes());
        pokemonDto = PokemonDto.fromJson(jsonDecode(jsonString));
        debugPrint('retrived from cache');
      }

      final result = pokemonDto.toModel();
      return result;
    } on DioException catch (e) {
      String err = "Dio exception handler: ${e.message ?? 'e.message is null'}";
      debugPrint(err);
      return Future.error(Exception(err));
    } on FormatException catch (e) {
      String err = "Format exception handler: ${e.message}";
      debugPrint(err);
      return Future.error(Exception(err));
    }
  }
}
