part of 'favorite_local_bloc.dart';

abstract class FavoriteLocalEvent extends Equatable {
  const FavoriteLocalEvent ();

  @override
  List<Object> get props  => [];
}

class FavoriteLocalIn extends FavoriteLocalEvent {}

class DeleteFavorite extends FavoriteLocalEvent {
  final String id;

  DeleteFavorite ({@required this.id});
}
