part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent ();

  @override
  List<Object> get props  => [];
}

class HomePageIn extends HomePageEvent {}

class SearchPageIn extends HomePageEvent {
  final String query;

  SearchPageIn({@required this.query});
}