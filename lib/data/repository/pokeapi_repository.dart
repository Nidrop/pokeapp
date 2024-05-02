import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pokeapp/data/data_source/pokeapi_data_source.dart';
import 'package:pokeapp/data/dto/mappers/pokemon_list_mapper.dart';
import 'package:pokeapp/data/dto/mappers/pokemon_mapper.dart';
import 'package:pokeapp/data/dto/pokemon_list_dto.dart';
import 'package:pokeapp/domain/model/pokemon.dart';
import 'package:pokeapp/domain/model/pokemon_list.dart';
import 'package:pokeapp/domain/repository/pokemon_repository.dart';

class PokeapiRepository implements PokemonRepository {
  final PokeapiDataSource _source;
  String? next = '';
  String? previous;

  PokeapiRepository(this._source);

  @override
  Future<PokemonList> getList() async {
    // TODO refactor
    try {
      // final cm = DefaultCacheManager();
      // final listDtoFileInfo = await cm.getFileFromCache('pokeapi');
      // File listDtoFile;
      // if (listDtoFileInfo == null) {
      //   final listDto = await _source.getList();
      //   //omg
      //   listDtoFile = await cm.putFile('pokeapi',
      //       Uint8List.fromList(utf8.encode(listDto.toJson().toString())));
      //   debugPrint('put to cache');
      // } else {
      //   listDtoFile = listDtoFileInfo.file;
      //   debugPrint('cache is available');
      // }
      // debugPrint('debugPrint: source: ${listDtoFileInfo?.source.name}');
      // //omg
      // final listDto = PokemonListDto.fromJson(
      //     jsonDecode(String.fromCharCodes(await listDtoFile.readAsBytes())));
      // debugPrint('retrived from cache');

      final listDto = await _source.getList(); //removable
      final result = listDto.toModel();
      next = result.next;
      previous = result.previous;
      return result;
    } on DioException catch (e) {
      String err =
          "Dio exception handler: ${e.message ?? 'e.message is null'}; ${e.stackTrace}";
      debugPrint(err);
      return Future.error(Exception(err));
    } on FormatException catch (e) {
      String err = "Format exception handler: ${e.message}";
      debugPrint(err);
      return Future.error(Exception(err));
    } on Exception {
      debugPrint('bruh');
      return Future.error(Exception('kekw'));
    }
  }

  @override
  Future<PokemonList> getListNext() async {
    if (next == null) {
      return Future.error(Exception('next is null'));
    }
    String args = '';
    try {
      args = next!.split('?')[1];
    } catch (e) {
      return Future.error(Exception('invalid url arguments'));
    }

    try {
      final listDto = await _source.getListWithArgs(args);
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
  Future<PokemonList> getListPrevious() async {
    if (previous == null) {
      return Future.error(Exception('previous is null'));
    }
    String args = '';
    try {
      args = previous!.split('?')[1];
    } catch (e) {
      return Future.error(Exception('invalid url arguments'));
    }

    try {
      final listDto = await _source.getListWithArgs(args);
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
  Future<Pokemon> getPokemon(int id) async {
    try {
      final pokemonDto = await _source.getPokemon(id);
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
