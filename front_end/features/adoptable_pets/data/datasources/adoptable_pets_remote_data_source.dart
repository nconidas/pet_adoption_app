import 'dart:convert';

import 'package:psso/core/error/exceptions.dart';
import 'package:psso/features/adoptable_pets/domain/entities/search_criteria.dart';

import 'package:http/http.dart' as http;
import '../models/adoptable_pets_model.dart';

abstract class AdoptablePetsRemoteDataSource {
  Future<AdoptablePetsModel> getAdoptablePets(SearchCriteria searchCriteria);
}

const PET_RESCUE_BASE_URL = 'www.petrescuezero.com';

class AdoptablePetsRemoteDataSourceImpl
    implements AdoptablePetsRemoteDataSource {
  final http.Client client;
  AdoptablePetsRemoteDataSourceImpl({required this.client});
  @override
  Future<AdoptablePetsModel> getAdoptablePets(
      SearchCriteria searchCriteria) async {
    final uri =
        Uri.http(PET_RESCUE_BASE_URL, 'adoptable_pets', searchCriteria.toMap());
    final response = await client.get(uri, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      return AdoptablePetsModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
