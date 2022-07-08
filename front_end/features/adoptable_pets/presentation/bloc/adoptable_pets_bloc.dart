import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:psso/features/adoptable_pets/domain/entities/adoptable_pets.dart';
import 'package:psso/features/adoptable_pets/domain/entities/search_criteria.dart';
import 'package:psso/features/adoptable_pets/domain/repositories/adoptable_pets_repository.dart';

import '../../domain/usecases/get_adoptable_pets.dart';

part 'adoptable_pets_event.dart';
part 'adoptable_pets_state.dart';

const INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Search Criteria';
const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class AdoptablePetsBloc extends Bloc<AdoptablePetsEvent, AdoptablePetsState> {
  final GetAdoptablePets getAdoptablePets;

  AdoptablePetsBloc({required this.getAdoptablePets})
      : super(AdoptablePetsInitial()) {
    on<AdoptablePetsRequested>((event, emit) async {
      emit(Loading());
      final petEither = await getAdoptablePets(event.criteria);
      petEither.fold((failure) {
        emit(Error(message: failure.message));
      }, (adoptablePets) {
        emit(Loaded(adoptablePets: adoptablePets));
      });
    });
  }
}
