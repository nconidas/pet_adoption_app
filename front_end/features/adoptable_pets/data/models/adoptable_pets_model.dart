import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/adoptable_pets.dart';

part 'adoptable_pets_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AdoptablePetModel extends AdoptablePet {
  const AdoptablePetModel(
      {required petId,
      name,
      species,
      breed,
      description,
      weight,
      age,
      List<String>? imageUrls})
      : super(
            petId: petId,
            name: name,
            species: species,
            breed: breed,
            description: description,
            weight: weight,
            age: age,
            imageUrls: imageUrls);

  factory AdoptablePetModel.fromJson(Map<String, dynamic> json) =>
      _$AdoptablePetModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdoptablePetModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AdoptablePetCategoryModel extends AdoptablePetCategory {
  final String categoryName;
  final List<AdoptablePetModel> adoptablePetList;

  const AdoptablePetCategoryModel({
    required this.categoryName,
    required this.adoptablePetList,
  }) : super(
          categoryName: categoryName,
          adoptablePetList: adoptablePetList,
        );

  factory AdoptablePetCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$AdoptablePetCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdoptablePetCategoryModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AdoptablePetsModel extends AdoptablePets {
  final List<AdoptablePetCategoryModel> adoptablePetCategories;

  const AdoptablePetsModel({
    required this.adoptablePetCategories,
  }) : super(
          adoptablePetCategories: adoptablePetCategories,
        );

  factory AdoptablePetsModel.fromJson(Map<String, dynamic> json) =>
      _$AdoptablePetsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdoptablePetsModelToJson(this);
}
