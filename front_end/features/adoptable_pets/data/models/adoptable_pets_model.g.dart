// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adoptable_pets_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdoptablePetModel _$AdoptablePetModelFromJson(Map<String, dynamic> json) =>
    AdoptablePetModel(
      petId: json['petId'],
      name: json['name'],
      species: json['species'],
      breed: json['breed'],
      description: json['description'],
      weight: json['weight'],
      age: json['age'],
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AdoptablePetModelToJson(AdoptablePetModel instance) =>
    <String, dynamic>{
      'petId': instance.petId,
      'name': instance.name,
      'species': instance.species,
      'breed': instance.breed,
      'description': instance.description,
      'imageUrls': instance.imageUrls,
      'weight': instance.weight,
      'age': instance.age,
    };

AdoptablePetCategoryModel _$AdoptablePetCategoryModelFromJson(
        Map<String, dynamic> json) =>
    AdoptablePetCategoryModel(
      categoryName: json['categoryName'] as String,
      adoptablePetList: (json['adoptablePetList'] as List<dynamic>)
          .map((e) => AdoptablePetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdoptablePetCategoryModelToJson(
        AdoptablePetCategoryModel instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'adoptablePetList':
          instance.adoptablePetList.map((e) => e.toJson()).toList(),
    };

AdoptablePetsModel _$AdoptablePetsModelFromJson(Map<String, dynamic> json) =>
    AdoptablePetsModel(
      adoptablePetCategories: (json['adoptablePetCategories'] as List<dynamic>)
          .map((e) =>
              AdoptablePetCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdoptablePetsModelToJson(AdoptablePetsModel instance) =>
    <String, dynamic>{
      'adoptablePetCategories':
          instance.adoptablePetCategories.map((e) => e.toJson()).toList(),
    };
