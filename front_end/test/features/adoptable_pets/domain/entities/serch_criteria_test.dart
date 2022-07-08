import 'package:flutter_test/flutter_test.dart';
import 'package:psso/features/adoptable_pets/domain/entities/search_criteria.dart';

Future<void> main() async {
  group('SearchCriteria', () {
    const tSearchCriteria = SearchCriteria(
        species: ['dog'],
        breed: ['German Shepherd', 'Collie'],
        size: ['large']);

    const tSearchCriteriaMap = {
      'species': ['dog'],
      'breed': ['German Shepherd', 'Collie'],
      'ageRange': null,
      'size': ['large']
    };
    test('Should return a map when to toMap method is called', () {
      final result = tSearchCriteria.toMap();
      expect(result, tSearchCriteriaMap);
    });
  });
}
