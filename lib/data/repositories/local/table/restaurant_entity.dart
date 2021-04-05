
import 'package:moor_flutter/moor_flutter.dart';

class RestaurantEntity extends Table{
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get pictureId => text()();
  TextColumn get city => text()();
  RealColumn get rating => real()();
  BoolColumn get isFavorite => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}