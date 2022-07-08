import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:psso/core/error/failure.dart';
import 'package:psso/features/adoptable_pets/domain/entities/adoptable_pets.dart';
import 'package:psso/features/adoptable_pets/domain/entities/search_criteria.dart';
import 'package:psso/features/adoptable_pets/domain/usecases/get_adoptable_pets.dart';
import 'package:psso/features/adoptable_pets/presentation/bloc/adoptable_pets_bloc.dart';
import 'package:psso/features/adoptable_pets/presentation/pages/adoptable_pet_browser.dart';
import 'adoptable_pets_bloc_test.mocks.dart';

@GenerateMocks([GetAdoptablePets])
void main() {
  late AdoptablePetsBloc bloc;
  late MockGetAdoptablePets mockGetAdoptablePets;

  setUp(() {
    mockGetAdoptablePets = MockGetAdoptablePets();
    bloc = AdoptablePetsBloc(getAdoptablePets: mockGetAdoptablePets);
  });

  test('initial state should be AdoptablePetsInitial', () {
    expect(bloc.state, AdoptablePetsInitial());
  });

  group('GetAdoptablePets', () {
    const tSearchCriteria = SearchCriteria();
    const tFailureMessage = 'Unexpected Error';
    final tAdoptablePet = const AdoptablePet(petId: 1);
    final tAdoptablePetCategory = AdoptablePetCategory(
        categoryName: "test", adoptablePetList: [tAdoptablePet]);
    final tAdoptablePets =
        AdoptablePets(adoptablePetCategories: [tAdoptablePetCategory]);
    final failureExpected = [Loading(), Error(message: tFailureMessage)];
    final successExpected = [Loading(), Loaded(adoptablePets: tAdoptablePets)];

    blocTest<AdoptablePetsBloc, AdoptablePetsState>(
      '''should emit [Loading, Loaded when the adoptable
       pets are gotten successfully''',
      setUp: () {
        when(mockGetAdoptablePets(any))
            .thenAnswer((_) async => Right(tAdoptablePets));
      },
      build: () => bloc,
      act: (bloc) =>
          bloc.add(AdoptablePetsRequested(criteria: tSearchCriteria)),
      expect: () => successExpected,
    );

    blocTest<AdoptablePetsBloc, AdoptablePetsState>(
      '''should emit [ Loading, Error] when getting adoptable
       pets fails''',
      setUp: () {
        when(mockGetAdoptablePets(any)).thenAnswer(
            (_) async => const Left(ServerFailure(tFailureMessage)));
      },
      build: () => bloc,
      act: (bloc) =>
          bloc.add(AdoptablePetsRequested(criteria: tSearchCriteria)),
      expect: () => failureExpected,
    );
  });
}
