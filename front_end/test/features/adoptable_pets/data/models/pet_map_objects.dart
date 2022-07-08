import 'package:psso/features/adoptable_pets/data/models/adoptable_pets_model.dart';

final tAdoptablePetModel = AdoptablePetModel(petId: 1);
final tAdoptablePetCategoryModel = AdoptablePetCategoryModel(
    categoryName: "test", adoptablePetList: [tAdoptablePetModel]);
final tAdoptablePetsModel =
    AdoptablePetsModel(adoptablePetCategories: [tAdoptablePetCategoryModel]);

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

final adoptablePetCategoryMap = {
  "categoryName": "test",
  "adoptablePetList": [
    {
      "petId": 1,
      "name": null,
      "species": null,
      "breed": null,
      "description": null,
      "weight": null,
      "age": null,
      "imageUrls": null
    }
  ]
};

final adoptablePetsMap = {
  "adoptablePetCategories": [
    {
      "categoryName": "test",
      "adoptablePetList": [
        {
          "petId": 1,
          "name": null,
          "species": null,
          "breed": null,
          "description": null,
          "weight": null,
          "age": null,
          "imageUrls": null
        }
      ]
    }
  ]
};
