
import 'package:submission2_flutter_expert/data/repositories/local/dao/restaurant_dao.dart';
import 'package:submission2_flutter_expert/data/repositories/local/table/restaurant_entity.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'app_database.g.dart';

@UseMoor(tables: [RestaurantEntity], daos: [RestaurantDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'resturant_db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;
}
