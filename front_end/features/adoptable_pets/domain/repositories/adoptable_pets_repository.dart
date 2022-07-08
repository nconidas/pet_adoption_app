import 'package:dartz/dartz.dart';
import 'package:psso/features/adoptable_pets/domain/entities/adoptable_pets.dart';

import '../../../../core/error/failure.dart';
import '../entities/search_criteria.dart';

abstract class AdoptablePetsRepository {
  Future<Either<Failure, AdoptablePets>> getAdoptablePets(
      SearchCriteria criteria);
}
