part of 'home_local_bloc.dart';

abstract class HomeLocalEvent extends Equatable {
  const HomeLocalEvent ();

  @override
  List<Object> get props  => [];
}

class HomeLocalIn extends HomeLocalEvent {}

class InsertIn extends HomeLocalEvent {
  final RestaurantEntityData data;

  InsertIn({@required this.data});
}