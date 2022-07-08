import 'package:equatable/equatable.dart';

class AdoptablePet extends Equatable {
  final int petId;
  final String? name;
  final String? species;
  final String? breed;
  final String? description;
  final List<String>? imageUrls;
  final String? weight;
  final String? age;

  const AdoptablePet(
      {required this.petId,
      this.name,
      this.species,
      this.breed,
      this.description,
      this.weight,
      this.age,
      this.imageUrls,
      s});

  @override
  List<Object> get props => [petId];
}

class AdoptablePetCategory extends Equatable {
  final String categoryName;
  final List<AdoptablePet> adoptablePetList;

  const AdoptablePetCategory({
    required this.categoryName,
    required this.adoptablePetList,
  });

  @override
  List<Object> get props => [categoryName, adoptablePetList];
}

class AdoptablePets extends Equatable {
  final List<AdoptablePetCategory> adoptablePetCategories;

  const AdoptablePets({
    required this.adoptablePetCategories,
  });

  @override
  List<Object> get props => [adoptablePetCategories];
}
