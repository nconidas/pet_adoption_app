import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:psso/core/error/exceptions.dart';
import 'package:psso/core/error/failure.dart';
import 'package:psso/features/adoptable_pets/data/datasources/adoptable_pets_remote_data_source.dart';
import 'package:psso/features/adoptable_pets/data/repositories/adoptable_pets_repository_impl.dart';
import 'package:psso/features/adoptable_pets/domain/entities/adoptable_pets.dart';
import 'package:psso/features/adoptable_pets/domain/entities/search_criteria.dart';

import '../models/pet_map_objects.dart';
import 'adoptable_pets_repository_impl_test.mocks.dart';

@GenerateMocks([AdoptablePetsRemoteDataSource])
void main() {
  late AdoptablePetsRepositoryImpl repository;
  late MockAdoptablePetsRemoteDataSource mockAdoptablePetsRemoteDataSource;

  setUp(() {
    mockAdoptablePetsRemoteDataSource = MockAdoptablePetsRemoteDataSource();
    repository = AdoptablePetsRepositoryImpl(
        remoteDataSource: mockAdoptablePetsRemoteDataSource);
  });

  group('getAdoptablePets', () {
    const tSearchCriteria = SearchCriteria();
    AdoptablePets tAdoptablePets = tAdoptablePetsModel;

    test(
        'should return right  when the remote datasrouce is successfully called',
        () async {
      when(mockAdoptablePetsRemoteDataSource.getAdoptablePets(any))
          .thenAnswer((_) async => tAdoptablePetsModel);
      final result = await repository.getAdoptablePets(tSearchCriteria);
      verify(
          mockAdoptablePetsRemoteDataSource.getAdoptablePets(tSearchCriteria));
      expect(result, Right(tAdoptablePets));
    });

    test(
        'should return remote data when the remote datasrouce is successfully called',
        () async {
      when(mockAdoptablePetsRemoteDataSource.getAdoptablePets(any))
          .thenAnswer((_) async => tAdoptablePetsModel);
      final result = await repository.getAdoptablePets(tSearchCriteria);
      verify(
          mockAdoptablePetsRemoteDataSource.getAdoptablePets(tSearchCriteria));
      expect(result, Right(tAdoptablePets));
    });

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockAdoptablePetsRemoteDataSource.getAdoptablePets(any))
            .thenThrow(ServerException('failure'));
        // act
        final result = await repository.getAdoptablePets(tSearchCriteria);
        // assert
        verify(mockAdoptablePetsRemoteDataSource
            .getAdoptablePets(tSearchCriteria));
        expect(result, Left(ServerFailure('failure')));
      },
    );
  });
}
