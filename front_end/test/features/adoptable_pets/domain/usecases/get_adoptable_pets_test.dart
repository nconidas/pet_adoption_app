import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:psso/features/adoptable_pets/domain/entities/adoptable_pets.dart';
import 'package:psso/features/adoptable_pets/domain/entities/search_criteria.dart';
import 'package:psso/features/adoptable_pets/domain/repositories/adoptable_pets_repository.dart';
import 'package:psso/features/adoptable_pets/domain/usecases/get_adoptable_pets.dart';

import 'get_adoptable_pets_test.mocks.dart';

@GenerateMocks([AdoptablePetsRepository])
void main() {
  const tCriteria = SearchCriteria();
  late MockAdoptablePetsRepository mockAdoptablePetsRepository;
  late GetAdoptablePets usecase;

  setUp(() {
    mockAdoptablePetsRepository = MockAdoptablePetsRepository();
    usecase = GetAdoptablePets(mockAdoptablePetsRepository);
  });

  final tAdoptablePet = AdoptablePet(petId: 1);
  final tAdoptablePetCategory = AdoptablePetCategory(
      categoryName: "test", adoptablePetList: [tAdoptablePet]);
  final tAdoptablePets =
      AdoptablePets(adoptablePetCategories: [tAdoptablePetCategory]);
  test(
    'should get AdoptablePets from the repository',
    () async {
      when(mockAdoptablePetsRepository.getAdoptablePets(any))
          .thenAnswer((realInvocation) async => Right(tAdoptablePets));
      final result = await usecase(tCriteria);
      expect(result, Right(tAdoptablePets));
      verify(mockAdoptablePetsRepository.getAdoptablePets(tCriteria));
      verifyNoMoreInteractions(mockAdoptablePetsRepository);
    },
  );
}
