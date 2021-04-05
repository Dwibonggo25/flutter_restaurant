part of 'detail_page_local_bloc.dart';

abstract class DetailLocalEvent extends Equatable {
  const DetailLocalEvent ();

  @override
  List<Object> get props  => [];
}

class DetailLocalIn extends DetailLocalEvent {
  final String id;

  DetailLocalIn ({@required this.id});
}

class SetDataFavorite extends DetailLocalEvent {
  final RestaurantEntityData data;

  SetDataFavorite ({@required this.data});
}