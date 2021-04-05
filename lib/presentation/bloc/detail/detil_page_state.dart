part of 'detil_page_bloc.dart';

abstract class DetilPageState {
  const DetilPageState();
}

class DetilPageInital extends DetilPageState {}

class DetilPageLoading extends DetilPageState {}

class DetilPageHasData extends DetilPageState {
  final DetilRestaurant data;

  DetilPageHasData({@required this.data});

  List<Object> get props => [data];
}

class DetilPageNoData extends DetilPageState {
  final String message;

  DetilPageNoData({@required this.message});

  List<Object> get props => [message];
}

class DetilPageError extends DetilPageState {
  final String message;

  DetilPageError({@required this.message});

  List<Object> get props => [message];
}