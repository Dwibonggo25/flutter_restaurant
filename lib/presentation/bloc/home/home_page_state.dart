part of 'home_page_bloc.dart';

abstract class HomePageState {
  const HomePageState();
}

class HomePageInital extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageHasData extends HomePageState {
  final List <Restaurant> data;

  HomePageHasData({@required this.data});

  List<Object> get props => [data];
}

class HomePageNoData extends HomePageState {
  final String message;

  HomePageNoData({@required this.message});

  List<Object> get props => [message];
}

class HomePageError extends HomePageState {
  final String message;

  HomePageError({@required this.message});

  List<Object> get props => [message];
}


