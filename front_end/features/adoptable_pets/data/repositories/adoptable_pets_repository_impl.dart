import 'package:psso/core/error/exceptions.dart';
import 'package:psso/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:psso/features/adoptable_pets/domain/entities/search_criteria.dart';
import 'package:psso/features/adoptable_pets/domain/entities/adoptable_pets.dart';

import '../../domain/repositories/adoptable_pets_repository.dart';
import '../datasources/adoptable_pets_remote_data_source.dart';

class AdoptablePetsRepositoryImpl implements AdoptablePetsRepository {
  final AdoptablePetsRemoteDataSource remoteDataSource;

  AdoptablePetsRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, AdoptablePets>> getAdoptablePets(
      SearchCriteria criteria) async {
    try {
      final adoptablePets = await remoteDataSource.getAdoptablePets(criteria);
      return Right(adoptablePets);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
