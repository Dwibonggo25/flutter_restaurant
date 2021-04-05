// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class RestaurantEntityData extends DataClass
    implements Insertable<RestaurantEntityData> {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final bool isFavorite;
  RestaurantEntityData(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.pictureId,
      @required this.city,
      @required this.rating,
      @required this.isFavorite});
  factory RestaurantEntityData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final boolType = db.typeSystem.forDartType<bool>();
    return RestaurantEntityData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      pictureId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}picture_id']),
      city: stringType.mapFromDatabaseResponse(data['${effectivePrefix}city']),
      rating:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}rating']),
      isFavorite: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_favorite']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || pictureId != null) {
      map['picture_id'] = Variable<String>(pictureId);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<double>(rating);
    }
    if (!nullToAbsent || isFavorite != null) {
      map['is_favorite'] = Variable<bool>(isFavorite);
    }
    return map;
  }

  RestaurantEntityCompanion toCompanion(bool nullToAbsent) {
    return RestaurantEntityCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      pictureId: pictureId == null && nullToAbsent
          ? const Value.absent()
          : Value(pictureId),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      isFavorite: isFavorite == null && nullToAbsent
          ? const Value.absent()
          : Value(isFavorite),
    );
  }

  factory RestaurantEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return RestaurantEntityData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      pictureId: serializer.fromJson<String>(json['pictureId']),
      city: serializer.fromJson<String>(json['city']),
      rating: serializer.fromJson<double>(json['rating']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'pictureId': serializer.toJson<String>(pictureId),
      'city': serializer.toJson<String>(city),
      'rating': serializer.toJson<double>(rating),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  RestaurantEntityData copyWith(
          {String id,
          String name,
          String description,
          String pictureId,
          String city,
          double rating,
          bool isFavorite}) =>
      RestaurantEntityData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        pictureId: pictureId ?? this.pictureId,
        city: city ?? this.city,
        rating: rating ?? this.rating,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  @override
  String toString() {
    return (StringBuffer('RestaurantEntityData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('pictureId: $pictureId, ')
          ..write('city: $city, ')
          ..write('rating: $rating, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              description.hashCode,
              $mrjc(
                  pictureId.hashCode,
                  $mrjc(city.hashCode,
                      $mrjc(rating.hashCode, isFavorite.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is RestaurantEntityData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.pictureId == this.pictureId &&
          other.city == this.city &&
          other.rating == this.rating &&
          other.isFavorite == this.isFavorite);
}

class RestaurantEntityCompanion extends UpdateCompanion<RestaurantEntityData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> pictureId;
  final Value<String> city;
  final Value<double> rating;
  final Value<bool> isFavorite;
  const RestaurantEntityCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.pictureId = const Value.absent(),
    this.city = const Value.absent(),
    this.rating = const Value.absent(),
    this.isFavorite = const Value.absent(),
  });
  RestaurantEntityCompanion.insert({
    @required String id,
    @required String name,
    @required String description,
    @required String pictureId,
    @required String city,
    @required double rating,
    @required bool isFavorite,
  })  : id = Value(id),
        name = Value(name),
        description = Value(description),
        pictureId = Value(pictureId),
        city = Value(city),
        rating = Value(rating),
        isFavorite = Value(isFavorite);
  static Insertable<RestaurantEntityData> custom({
    Expression<String> id,
    Expression<String> name,
    Expression<String> description,
    Expression<String> pictureId,
    Expression<String> city,
    Expression<double> rating,
    Expression<bool> isFavorite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (pictureId != null) 'picture_id': pictureId,
      if (city != null) 'city': city,
      if (rating != null) 'rating': rating,
      if (isFavorite != null) 'is_favorite': isFavorite,
    });
  }

  RestaurantEntityCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> description,
      Value<String> pictureId,
      Value<String> city,
      Value<double> rating,
      Value<bool> isFavorite}) {
    return RestaurantEntityCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      pictureId: pictureId ?? this.pictureId,
      city: city ?? this.city,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (pictureId.present) {
      map['picture_id'] = Variable<String>(pictureId.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RestaurantEntityCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('pictureId: $pictureId, ')
          ..write('city: $city, ')
          ..write('rating: $rating, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }
}

class $RestaurantEntityTable extends RestaurantEntity
    with TableInfo<$RestaurantEntityTable, RestaurantEntityData> {
  final GeneratedDatabase _db;
  final String _alias;
  $RestaurantEntityTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pictureIdMeta = const VerificationMeta('pictureId');
  GeneratedTextColumn _pictureId;
  @override
  GeneratedTextColumn get pictureId => _pictureId ??= _constructPictureId();
  GeneratedTextColumn _constructPictureId() {
    return GeneratedTextColumn(
      'picture_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _cityMeta = const VerificationMeta('city');
  GeneratedTextColumn _city;
  @override
  GeneratedTextColumn get city => _city ??= _constructCity();
  GeneratedTextColumn _constructCity() {
    return GeneratedTextColumn(
      'city',
      $tableName,
      false,
    );
  }

  final VerificationMeta _ratingMeta = const VerificationMeta('rating');
  GeneratedRealColumn _rating;
  @override
  GeneratedRealColumn get rating => _rating ??= _constructRating();
  GeneratedRealColumn _constructRating() {
    return GeneratedRealColumn(
      'rating',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isFavoriteMeta = const VerificationMeta('isFavorite');
  GeneratedBoolColumn _isFavorite;
  @override
  GeneratedBoolColumn get isFavorite => _isFavorite ??= _constructIsFavorite();
  GeneratedBoolColumn _constructIsFavorite() {
    return GeneratedBoolColumn(
      'is_favorite',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, pictureId, city, rating, isFavorite];
  @override
  $RestaurantEntityTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'restaurant_entity';
  @override
  final String actualTableName = 'restaurant_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<RestaurantEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('picture_id')) {
      context.handle(_pictureIdMeta,
          pictureId.isAcceptableOrUnknown(data['picture_id'], _pictureIdMeta));
    } else if (isInserting) {
      context.missing(_pictureIdMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city'], _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating'], _ratingMeta));
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite'], _isFavoriteMeta));
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RestaurantEntityData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return RestaurantEntityData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $RestaurantEntityTable createAlias(String alias) {
    return $RestaurantEntityTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $RestaurantEntityTable _restaurantEntity;
  $RestaurantEntityTable get restaurantEntity =>
      _restaurantEntity ??= $RestaurantEntityTable(this);
  RestaurantDao _restaurantDao;
  RestaurantDao get restaurantDao =>
      _restaurantDao ??= RestaurantDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [restaurantEntity];
}
