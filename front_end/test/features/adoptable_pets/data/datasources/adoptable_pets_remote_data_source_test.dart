import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:psso/core/error/exceptions.dart';
import 'package:psso/features/adoptable_pets/data/datasources/adoptable_pets_remote_data_source.dart';
import 'package:psso/features/adoptable_pets/data/models/adoptable_pets_model.dart';
import 'package:psso/features/adoptable_pets/domain/entities/search_criteria.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'adoptable_pets_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  late AdoptablePetsRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = AdoptablePetsRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getAdoptablePets', () {
    final tAdoptablePetModel = AdoptablePetModel(petId: 1);
    final tAdoptablePetCategoryModel = AdoptablePetCategoryModel(
        categoryName: "test", adoptablePetList: [tAdoptablePetModel]);
    final tAdoptablePetsModel = AdoptablePetsModel(
        adoptablePetCategories: [tAdoptablePetCategoryModel]);
    const tSearchCriteria = SearchCriteria();

    test('''should perform a GET request on the adoption url with the 
        application/json header''', () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('adoptable_pets.json'), 200));

      final uri = Uri.http(
          PET_RESCUE_BASE_URL, 'adoptable_pets', tSearchCriteria.toMap());
      dataSource.getAdoptablePets(tSearchCriteria);
      verify(mockHttpClient
          .get(uri, headers: {'Content-Type': 'application/json'}));
    });

    test('''should return an AdoptablePets when the response is 200 success''',
        () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('adoptable_pets.json'), 200));

      final result = await dataSource.getAdoptablePets(tSearchCriteria);
      expect(result, tAdoptablePetsModel);
    });

    test('''should throw server exception when the response is 404 or other''',
        () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response('Something bad happened', 404));

      final call = dataSource.getAdoptablePets;
      expect(() => call(tSearchCriteria),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
