import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:psso/features/adoptable_pets/data/models/adoptable_pets_model.dart';
import 'package:psso/features/adoptable_pets/domain/entities/adoptable_pets.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'pet_map_objects.dart';

void main() {
  group('AdoptablePetModel', () {
    test('should be a subclass of AdoptablePets entity', () async {
      expect(tAdoptablePetModel, isA<AdoptablePet>());
    });
    test(
      'should return a valid model when the JSON petId is an integer',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('adoptable_pet.json'));
        // act
        final result = AdoptablePetModel.fromJson(jsonMap);
        // assert
        expect(result, tAdoptablePetModel);
      },
    );
    test(
      'should return a json map containing the proper data',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('adoptable_pet_category.json'));
        // act
        final result = tAdoptablePetModel.toJson();
        const adoptablePetMap = {
          "petId": 1,
          "name": null,
          "species": null,
          "breed": null,
          "description": null,
          "weight": null,
          "age": null,
          "imageUrls": null
        };
        // assert
        expect(result, adoptablePetMap);
      },
    );
  });

  group('AdoptablePetCategory', () {
    test('should be a subclass of AdoptablePetCategory entity', () async {
      expect(tAdoptablePetCategoryModel, isA<AdoptablePetCategory>());
    });
    test(
      'should return a valid adoptablePetCategory model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('adoptable_pet_category.json'));
        // act
        final result = AdoptablePetCategoryModel.fromJson(jsonMap);
        // assert
        expect(result, tAdoptablePetCategoryModel);
      },
    );
    test(
      'should return a json map containing the proper data',
      () async {
        // act
        final result = tAdoptablePetCategoryModel.toJson();
        // assert
        expect(result, adoptablePetCategoryMap);
      },
    );
  });

  group('AdoptablePetsModel', () {
    test('should be a subclass of AdoptablePetCategory entity', () async {
      expect(tAdoptablePetsModel, isA<AdoptablePets>());
    });
    test(
      'should return a valid adoptablePetsModel',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('adoptable_pets.json'));
        // act
        final result = AdoptablePetsModel.fromJson(jsonMap);
        // assert
        expect(result, tAdoptablePetsModel);
      },
    );
    test(
      'should return a json map containing the proper data',
      () async {
        // act
        final result = tAdoptablePetsModel.toJson();
        // assert
        expect(result, adoptablePetsMap);
      },
    );
  });
}
