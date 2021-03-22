part of 'detil_page_bloc.dart';

abstract class DetilPageEvent extends Equatable {
  const DetilPageEvent ();

  @override
  List<Object> get props  => [];
}

class DetilPageIn extends DetilPageEvent {
  final String idRestaurant;

  DetilPageIn({@required this.idRestaurant});
}