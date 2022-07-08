import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';

class AgeRange extends Equatable {
  final int minAge;
  final int maxAge;

  const AgeRange(this.minAge, this.maxAge);

  @override
  List<Object> get props => [minAge, maxAge];
}

class SearchCriteria extends Equatable {
  // Allow for multiple species selections.
  final List<String>? species;
  // Allow for multiple breed selections.
  final List<String>? breed;
  // Allow greater than, less than, between age selection.
  final AgeRange? ageRange;
  // Allow multiple size selections ex. [large, extraLarge].
  final List<String>? size;

  const SearchCriteria({this.species, this.breed, this.ageRange, this.size});

  Map<String, dynamic> toMap() {
    return {
      'species': species,
      'breed': breed,
      'ageRange': ageRange,
      'size': size,
    };
  }

  @override
  List<Object> get props => [];
}

class InvalidInputFailure extends Failure {}
