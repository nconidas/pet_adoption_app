part of 'adoptable_pets_bloc.dart';

@immutable
abstract class AdoptablePetsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AdoptablePetsRequested extends AdoptablePetsEvent {
  final SearchCriteria criteria;

  AdoptablePetsRequested({required this.criteria});

  @override
  List<Object> get props => [criteria];
}
