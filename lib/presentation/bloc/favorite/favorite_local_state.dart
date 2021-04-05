part of 'favorite_local_bloc.dart';

abstract class
FavoriteLocalState {
  const FavoriteLocalState();
}

class FavoriteLocalInital extends FavoriteLocalState {}

class FavoriteLocalLoading extends FavoriteLocalState {}

class FavoriteLocalHasData extends FavoriteLocalState {
  final List <RestaurantEntityData> data;

  FavoriteLocalHasData({@required this.data});

  List<Object> get props => [data];
}

class FavoriteLocalNoData extends FavoriteLocalState {
  final String message;

  FavoriteLocalNoData({@required this.message});

  List<Object> get props => [message];
}

class FavoriteLocalError extends FavoriteLocalState {
  final String message;

  FavoriteLocalError({@required this.message});

  List<Object> get props => [message];
}

class UpdateLocalSuccess extends FavoriteLocalState {}