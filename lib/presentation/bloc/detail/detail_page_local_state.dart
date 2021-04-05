part of 'detail_page_local_bloc.dart';

abstract class DetailLocalState {
  const DetailLocalState();
}

class DetailLocalInital extends DetailLocalState {}

class DetailLocalLoading extends DetailLocalState {}

class DetailLocalError extends DetailLocalState {
  final String message;

  DetailLocalError({@required this.message});

  List<Object> get props => [message];
}

class GetDetailSuccess extends DetailLocalState {
  final RestaurantEntityData data;

  GetDetailSuccess({@required this.data});
}

class UpdateFavoriteSucccess extends DetailLocalState{}