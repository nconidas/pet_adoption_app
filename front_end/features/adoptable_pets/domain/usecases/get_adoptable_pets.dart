import 'package:dartz/dartz.dart';
import 'package:psso/features/adoptable_pets/domain/entities/adoptable_pets.dart';
import 'package:psso/features/adoptable_pets/domain/entities/search_criteria.dart';

import '../../../../core/error/failure.dart';
import '../repositories/adoptable_pets_repository.dart';

class GetAdoptablePets {
  final AdoptablePetsRepository repository;

  GetAdoptablePets(this.repository);

  @override
  Future<Either<Failure, AdoptablePets>> call(SearchCriteria criteria) async {
    return repository.getAdoptablePets(criteria);
  }
}
