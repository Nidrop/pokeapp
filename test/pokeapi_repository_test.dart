import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokeapp/data/data_source/pokeapi_data_source.dart';
import 'package:pokeapp/data/repository/pokeapi_repository.dart';

void main() {
  group('remote repository test:', () {
    final api = PokeapiRepository(PokeapiDataSource(Dio()));
    test('get middle item from list', () async {
      final r = await api.getList();

      expect(r.names.contains('metapod'), true);
    });

    test('get middle item from second page', () async {
      final r = await api.getListNext();

      expect(r.names.contains('nidoqueen'), true);
    });

    test('get bulbasaur item from previous page', () async {
      final r = await api.getListPrevious();

      expect(r.names.contains('bulbasaur'), true);
    });

    test('get bulbasaur details', () async {
      final r = await api.getPokemon(1);

      expect(r.name, 'bulbasaur');
      expect(r.height, 70);
      expect(r.weight, 6.9);
      expect(r.types.contains('grass'), true);
      expect(r.types.contains('poison'), true);
    });
  });
}
