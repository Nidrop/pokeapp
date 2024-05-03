import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pokeapp/data/data_source/pokeapi_data_source.dart';
import 'package:pokeapp/data/repository/pokeapi_repository.dart';

import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

const String kTemporaryPath = 'temporaryPath';
const String kApplicationSupportPath = 'applicationSupportPath';
const String kDownloadsPath = 'downloadsPath';
const String kLibraryPath = 'libraryPath';
const String kApplicationDocumentsPath = 'applicationDocumentsPath';
const String kExternalCachePath = 'externalCachePath';
const String kExternalStoragePath = 'externalStoragePath';

const String getListResponse =
    '{"count":1302,"next":"https://pokeapi.co/api/v2/pokemon?offset=20&limit=20","previous":null,"results":[{"name":"bulbasaur","url":"https://pokeapi.co/api/v2/pokemon/1/"},{"name":"ivysaur","url":"https://pokeapi.co/api/v2/pokemon/2/"},{"name":"venusaur","url":"https://pokeapi.co/api/v2/pokemon/3/"},{"name":"charmander","url":"https://pokeapi.co/api/v2/pokemon/4/"},{"name":"charmeleon","url":"https://pokeapi.co/api/v2/pokemon/5/"},{"name":"charizard","url":"https://pokeapi.co/api/v2/pokemon/6/"},{"name":"squirtle","url":"https://pokeapi.co/api/v2/pokemon/7/"},{"name":"wartortle","url":"https://pokeapi.co/api/v2/pokemon/8/"},{"name":"blastoise","url":"https://pokeapi.co/api/v2/pokemon/9/"},{"name":"caterpie","url":"https://pokeapi.co/api/v2/pokemon/10/"},{"name":"metapod","url":"https://pokeapi.co/api/v2/pokemon/11/"},{"name":"butterfree","url":"https://pokeapi.co/api/v2/pokemon/12/"},{"name":"weedle","url":"https://pokeapi.co/api/v2/pokemon/13/"},{"name":"kakuna","url":"https://pokeapi.co/api/v2/pokemon/14/"},{"name":"beedrill","url":"https://pokeapi.co/api/v2/pokemon/15/"},{"name":"pidgey","url":"https://pokeapi.co/api/v2/pokemon/16/"},{"name":"pidgeotto","url":"https://pokeapi.co/api/v2/pokemon/17/"},{"name":"pidgeot","url":"https://pokeapi.co/api/v2/pokemon/18/"},{"name":"rattata","url":"https://pokeapi.co/api/v2/pokemon/19/"},{"name":"raticate","url":"https://pokeapi.co/api/v2/pokemon/20/"}]}';
void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();
  late Dio dio;
  late DioAdapter dioAdapter;
  late PokeapiRepository api;
  group('remote repository test:', () {
    setUp(() {
      // PathProviderPlatform.instance = FakePathProviderPlatform();
      // dio = Dio(/*BaseOptions()*/);
      // dioAdapter = DioAdapter(dio: dio);

      // api = PokeapiRepository(PokeapiDataSource(dio));
    });

    dio = Dio(/*BaseOptions()*/);
    api = PokeapiRepository(PokeapiDataSource(dio));
    test('get middle item from list', () async {
      // dioAdapter.onGet("https://pokeapi.co/api/v2/pokemon",
      //     (server) => server.reply(200, getListResponse));

      final r = await api.getList(skipCache: true);

      expect(r.names.contains('metapod'), true);
    });

    test('get middle item from second page', () async {
      final r = await api.getListNext(skipCache: true);

      expect(r.names.contains('nidoqueen'), true);
    });

    // test('get bulbasaur item from previous page', () async {
    //   final r = await api.getListPrevious();

    //   expect(r.names.contains('bulbasaur'), true);
    // });

    test('get bulbasaur details', () async {
      const name = 'bulbasaur';
      final r = await api.getPokemon(name, skipCache: true);

      expect(r.name, name);
      expect(r.height, 70);
      expect(r.weight, 6.9);
      expect(r.types.contains('grass'), true);
      expect(r.types.contains('poison'), true);
    });
  });
}

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async {
    return kTemporaryPath;
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return kApplicationSupportPath;
  }

  @override
  Future<String?> getLibraryPath() async {
    return kLibraryPath;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return kExternalStoragePath;
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    return <String>[kExternalCachePath];
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return <String>[kExternalStoragePath];
  }

  @override
  Future<String?> getDownloadsPath() async {
    return kDownloadsPath;
  }
}
