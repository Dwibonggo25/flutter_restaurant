
import 'package:moor_flutter/moor_flutter.dart';
import 'package:submission2_flutter_expert/data/repositories/db/app_database.dart';
import 'package:submission2_flutter_expert/data/repositories/local/table/restaurant_entity.dart';

part 'restaurant_dao.g.dart';

@UseDao(tables: [RestaurantEntity])
class RestaurantDao extends  DatabaseAccessor<AppDatabase> with _$RestaurantDaoMixin{
  RestaurantDao(AppDatabase db) : super(db);

  Future insertDataToFavorite (RestaurantEntityData data) =>
      into(restaurantEntity).insert(data, mode: InsertMode.insertOrReplace);

  Future updateFavorite(String data)  {
    return (update(restaurantEntity)..where((id) => id.id.equals(data)))
        .write(RestaurantEntityCompanion(isFavorite: Value(false)));
  }

  Future<List<RestaurantEntityData>> getAllFavoriteLocal() => (select(restaurantEntity)..where((isFavorite) => isFavorite.isFavorite.equals(true))).get();

  Future <RestaurantEntityData> getDetailRestaurant(String id) => (select(restaurantEntity)..where((tbl) => tbl.id.equals(id))).getSingle();
}