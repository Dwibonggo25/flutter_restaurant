part of 'home_local_bloc.dart';

abstract class HomeLocalState {
  const HomeLocalState();
}

class HomeLocalInital extends HomeLocalState {}

class HomeLocalLoading extends HomeLocalState {}

class HomeLocalError extends HomeLocalState {
  final String message;

  HomeLocalError({@required this.message});

  List<Object> get props => [message];
}

class UpdateFavoriteSucccess extends HomeLocalState{}