// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_database.dart';

// ignore_for_file: type=lint
class $StepRecordsTable extends StepRecords
    with TableInfo<$StepRecordsTable, StepRecordDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StepRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
    'steps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isAutoSyncMeta = const VerificationMeta(
    'isAutoSync',
  );
  @override
  late final GeneratedColumn<bool> isAutoSync = GeneratedColumn<bool>(
    'is_auto_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_auto_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    steps,
    isAutoSync,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'step_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<StepRecordDb> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('steps')) {
      context.handle(
        _stepsMeta,
        steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta),
      );
    } else if (isInserting) {
      context.missing(_stepsMeta);
    }
    if (data.containsKey('is_auto_sync')) {
      context.handle(
        _isAutoSyncMeta,
        isAutoSync.isAcceptableOrUnknown(
          data['is_auto_sync']!,
          _isAutoSyncMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StepRecordDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StepRecordDb(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      steps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}steps'],
      )!,
      isAutoSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_auto_sync'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $StepRecordsTable createAlias(String alias) {
    return $StepRecordsTable(attachedDatabase, alias);
  }
}

class StepRecordDb extends DataClass implements Insertable<StepRecordDb> {
  final String id;
  final DateTime date;
  final int steps;
  final bool isAutoSync;
  final DateTime? createdAt;
  const StepRecordDb({
    required this.id,
    required this.date,
    required this.steps,
    required this.isAutoSync,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['steps'] = Variable<int>(steps);
    map['is_auto_sync'] = Variable<bool>(isAutoSync);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  StepRecordsCompanion toCompanion(bool nullToAbsent) {
    return StepRecordsCompanion(
      id: Value(id),
      date: Value(date),
      steps: Value(steps),
      isAutoSync: Value(isAutoSync),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory StepRecordDb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StepRecordDb(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      steps: serializer.fromJson<int>(json['steps']),
      isAutoSync: serializer.fromJson<bool>(json['isAutoSync']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'steps': serializer.toJson<int>(steps),
      'isAutoSync': serializer.toJson<bool>(isAutoSync),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  StepRecordDb copyWith({
    String? id,
    DateTime? date,
    int? steps,
    bool? isAutoSync,
    Value<DateTime?> createdAt = const Value.absent(),
  }) => StepRecordDb(
    id: id ?? this.id,
    date: date ?? this.date,
    steps: steps ?? this.steps,
    isAutoSync: isAutoSync ?? this.isAutoSync,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  StepRecordDb copyWithCompanion(StepRecordsCompanion data) {
    return StepRecordDb(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      steps: data.steps.present ? data.steps.value : this.steps,
      isAutoSync: data.isAutoSync.present
          ? data.isAutoSync.value
          : this.isAutoSync,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StepRecordDb(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('steps: $steps, ')
          ..write('isAutoSync: $isAutoSync, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, steps, isAutoSync, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StepRecordDb &&
          other.id == this.id &&
          other.date == this.date &&
          other.steps == this.steps &&
          other.isAutoSync == this.isAutoSync &&
          other.createdAt == this.createdAt);
}

class StepRecordsCompanion extends UpdateCompanion<StepRecordDb> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<int> steps;
  final Value<bool> isAutoSync;
  final Value<DateTime?> createdAt;
  final Value<int> rowid;
  const StepRecordsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.steps = const Value.absent(),
    this.isAutoSync = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StepRecordsCompanion.insert({
    required String id,
    required DateTime date,
    required int steps,
    this.isAutoSync = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       steps = Value(steps);
  static Insertable<StepRecordDb> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<int>? steps,
    Expression<bool>? isAutoSync,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (steps != null) 'steps': steps,
      if (isAutoSync != null) 'is_auto_sync': isAutoSync,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StepRecordsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<int>? steps,
    Value<bool>? isAutoSync,
    Value<DateTime?>? createdAt,
    Value<int>? rowid,
  }) {
    return StepRecordsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      steps: steps ?? this.steps,
      isAutoSync: isAutoSync ?? this.isAutoSync,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (isAutoSync.present) {
      map['is_auto_sync'] = Variable<bool>(isAutoSync.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StepRecordsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('steps: $steps, ')
          ..write('isAutoSync: $isAutoSync, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeightRecordsTable extends WeightRecords
    with TableInfo<$WeightRecordsTable, WeightRecordDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeightRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, weight, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weight_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeightRecordDb> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeightRecordDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeightRecordDb(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $WeightRecordsTable createAlias(String alias) {
    return $WeightRecordsTable(attachedDatabase, alias);
  }
}

class WeightRecordDb extends DataClass implements Insertable<WeightRecordDb> {
  final String id;
  final DateTime date;
  final double weight;
  final DateTime? createdAt;
  const WeightRecordDb({
    required this.id,
    required this.date,
    required this.weight,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['weight'] = Variable<double>(weight);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  WeightRecordsCompanion toCompanion(bool nullToAbsent) {
    return WeightRecordsCompanion(
      id: Value(id),
      date: Value(date),
      weight: Value(weight),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory WeightRecordDb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightRecordDb(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      weight: serializer.fromJson<double>(json['weight']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'weight': serializer.toJson<double>(weight),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  WeightRecordDb copyWith({
    String? id,
    DateTime? date,
    double? weight,
    Value<DateTime?> createdAt = const Value.absent(),
  }) => WeightRecordDb(
    id: id ?? this.id,
    date: date ?? this.date,
    weight: weight ?? this.weight,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  WeightRecordDb copyWithCompanion(WeightRecordsCompanion data) {
    return WeightRecordDb(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      weight: data.weight.present ? data.weight.value : this.weight,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeightRecordDb(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, weight, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightRecordDb &&
          other.id == this.id &&
          other.date == this.date &&
          other.weight == this.weight &&
          other.createdAt == this.createdAt);
}

class WeightRecordsCompanion extends UpdateCompanion<WeightRecordDb> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<double> weight;
  final Value<DateTime?> createdAt;
  final Value<int> rowid;
  const WeightRecordsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.weight = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeightRecordsCompanion.insert({
    required String id,
    required DateTime date,
    required double weight,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       weight = Value(weight);
  static Insertable<WeightRecordDb> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<double>? weight,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (weight != null) 'weight': weight,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeightRecordsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<double>? weight,
    Value<DateTime?>? createdAt,
    Value<int>? rowid,
  }) {
    return WeightRecordsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightRecordsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weight: $weight, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TemperatureRecordsTable extends TemperatureRecords
    with TableInfo<$TemperatureRecordsTable, TemperatureRecordDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemperatureRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
    'temperature',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, temperature, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'temperature_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<TemperatureRecordDb> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_temperatureMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TemperatureRecordDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemperatureRecordDb(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $TemperatureRecordsTable createAlias(String alias) {
    return $TemperatureRecordsTable(attachedDatabase, alias);
  }
}

class TemperatureRecordDb extends DataClass
    implements Insertable<TemperatureRecordDb> {
  final String id;
  final DateTime date;
  final double temperature;
  final DateTime? createdAt;
  const TemperatureRecordDb({
    required this.id,
    required this.date,
    required this.temperature,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['temperature'] = Variable<double>(temperature);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  TemperatureRecordsCompanion toCompanion(bool nullToAbsent) {
    return TemperatureRecordsCompanion(
      id: Value(id),
      date: Value(date),
      temperature: Value(temperature),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory TemperatureRecordDb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemperatureRecordDb(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      temperature: serializer.fromJson<double>(json['temperature']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'temperature': serializer.toJson<double>(temperature),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  TemperatureRecordDb copyWith({
    String? id,
    DateTime? date,
    double? temperature,
    Value<DateTime?> createdAt = const Value.absent(),
  }) => TemperatureRecordDb(
    id: id ?? this.id,
    date: date ?? this.date,
    temperature: temperature ?? this.temperature,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  TemperatureRecordDb copyWithCompanion(TemperatureRecordsCompanion data) {
    return TemperatureRecordDb(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      temperature: data.temperature.present
          ? data.temperature.value
          : this.temperature,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TemperatureRecordDb(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('temperature: $temperature, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, temperature, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemperatureRecordDb &&
          other.id == this.id &&
          other.date == this.date &&
          other.temperature == this.temperature &&
          other.createdAt == this.createdAt);
}

class TemperatureRecordsCompanion extends UpdateCompanion<TemperatureRecordDb> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<double> temperature;
  final Value<DateTime?> createdAt;
  final Value<int> rowid;
  const TemperatureRecordsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.temperature = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TemperatureRecordsCompanion.insert({
    required String id,
    required DateTime date,
    required double temperature,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       temperature = Value(temperature);
  static Insertable<TemperatureRecordDb> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<double>? temperature,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (temperature != null) 'temperature': temperature,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TemperatureRecordsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<double>? temperature,
    Value<DateTime?>? createdAt,
    Value<int>? rowid,
  }) {
    return TemperatureRecordsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      temperature: temperature ?? this.temperature,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemperatureRecordsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('temperature: $temperature, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseRecordsTable extends ExerciseRecords
    with TableInfo<$ExerciseRecordsTable, ExerciseRecordDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseTypeMeta = const VerificationMeta(
    'exerciseType',
  );
  @override
  late final GeneratedColumn<String> exerciseType = GeneratedColumn<String>(
    'exercise_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    exerciseType,
    durationMinutes,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseRecordDb> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('exercise_type')) {
      context.handle(
        _exerciseTypeMeta,
        exerciseType.isAcceptableOrUnknown(
          data['exercise_type']!,
          _exerciseTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseTypeMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseRecordDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseRecordDb(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      exerciseType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_type'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $ExerciseRecordsTable createAlias(String alias) {
    return $ExerciseRecordsTable(attachedDatabase, alias);
  }
}

class ExerciseRecordDb extends DataClass
    implements Insertable<ExerciseRecordDb> {
  final String id;
  final DateTime date;
  final String exerciseType;
  final int durationMinutes;
  final String? note;
  final DateTime? createdAt;
  const ExerciseRecordDb({
    required this.id,
    required this.date,
    required this.exerciseType,
    required this.durationMinutes,
    this.note,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['exercise_type'] = Variable<String>(exerciseType);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  ExerciseRecordsCompanion toCompanion(bool nullToAbsent) {
    return ExerciseRecordsCompanion(
      id: Value(id),
      date: Value(date),
      exerciseType: Value(exerciseType),
      durationMinutes: Value(durationMinutes),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory ExerciseRecordDb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseRecordDb(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      exerciseType: serializer.fromJson<String>(json['exerciseType']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'exerciseType': serializer.toJson<String>(exerciseType),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  ExerciseRecordDb copyWith({
    String? id,
    DateTime? date,
    String? exerciseType,
    int? durationMinutes,
    Value<String?> note = const Value.absent(),
    Value<DateTime?> createdAt = const Value.absent(),
  }) => ExerciseRecordDb(
    id: id ?? this.id,
    date: date ?? this.date,
    exerciseType: exerciseType ?? this.exerciseType,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    note: note.present ? note.value : this.note,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  ExerciseRecordDb copyWithCompanion(ExerciseRecordsCompanion data) {
    return ExerciseRecordDb(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      exerciseType: data.exerciseType.present
          ? data.exerciseType.value
          : this.exerciseType,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseRecordDb(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('exerciseType: $exerciseType, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, exerciseType, durationMinutes, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseRecordDb &&
          other.id == this.id &&
          other.date == this.date &&
          other.exerciseType == this.exerciseType &&
          other.durationMinutes == this.durationMinutes &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class ExerciseRecordsCompanion extends UpdateCompanion<ExerciseRecordDb> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String> exerciseType;
  final Value<int> durationMinutes;
  final Value<String?> note;
  final Value<DateTime?> createdAt;
  final Value<int> rowid;
  const ExerciseRecordsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.exerciseType = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseRecordsCompanion.insert({
    required String id,
    required DateTime date,
    required String exerciseType,
    required int durationMinutes,
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       exerciseType = Value(exerciseType),
       durationMinutes = Value(durationMinutes);
  static Insertable<ExerciseRecordDb> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? exerciseType,
    Expression<int>? durationMinutes,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (exerciseType != null) 'exercise_type': exerciseType,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseRecordsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<String>? exerciseType,
    Value<int>? durationMinutes,
    Value<String?>? note,
    Value<DateTime?>? createdAt,
    Value<int>? rowid,
  }) {
    return ExerciseRecordsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      exerciseType: exerciseType ?? this.exerciseType,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (exerciseType.present) {
      map['exercise_type'] = Variable<String>(exerciseType.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseRecordsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('exerciseType: $exerciseType, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HealthGoalsTable extends HealthGoals
    with TableInfo<$HealthGoalsTable, HealthGoalDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HealthGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetValueMeta = const VerificationMeta(
    'targetValue',
  );
  @override
  late final GeneratedColumn<double> targetValue = GeneratedColumn<double>(
    'target_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    targetValue,
    startDate,
    endDate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'health_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<HealthGoalDb> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('target_value')) {
      context.handle(
        _targetValueMeta,
        targetValue.isAcceptableOrUnknown(
          data['target_value']!,
          _targetValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetValueMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HealthGoalDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HealthGoalDb(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      targetValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_value'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $HealthGoalsTable createAlias(String alias) {
    return $HealthGoalsTable(attachedDatabase, alias);
  }
}

class HealthGoalDb extends DataClass implements Insertable<HealthGoalDb> {
  final String id;
  final String type;
  final double targetValue;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime? createdAt;
  const HealthGoalDb({
    required this.id,
    required this.type,
    required this.targetValue,
    required this.startDate,
    this.endDate,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['target_value'] = Variable<double>(targetValue);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  HealthGoalsCompanion toCompanion(bool nullToAbsent) {
    return HealthGoalsCompanion(
      id: Value(id),
      type: Value(type),
      targetValue: Value(targetValue),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory HealthGoalDb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HealthGoalDb(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      targetValue: serializer.fromJson<double>(json['targetValue']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'targetValue': serializer.toJson<double>(targetValue),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  HealthGoalDb copyWith({
    String? id,
    String? type,
    double? targetValue,
    DateTime? startDate,
    Value<DateTime?> endDate = const Value.absent(),
    Value<DateTime?> createdAt = const Value.absent(),
  }) => HealthGoalDb(
    id: id ?? this.id,
    type: type ?? this.type,
    targetValue: targetValue ?? this.targetValue,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  HealthGoalDb copyWithCompanion(HealthGoalsCompanion data) {
    return HealthGoalDb(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      targetValue: data.targetValue.present
          ? data.targetValue.value
          : this.targetValue,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HealthGoalDb(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('targetValue: $targetValue, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, targetValue, startDate, endDate, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HealthGoalDb &&
          other.id == this.id &&
          other.type == this.type &&
          other.targetValue == this.targetValue &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.createdAt == this.createdAt);
}

class HealthGoalsCompanion extends UpdateCompanion<HealthGoalDb> {
  final Value<String> id;
  final Value<String> type;
  final Value<double> targetValue;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<DateTime?> createdAt;
  final Value<int> rowid;
  const HealthGoalsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HealthGoalsCompanion.insert({
    required String id,
    required String type,
    required double targetValue,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       targetValue = Value(targetValue),
       startDate = Value(startDate);
  static Insertable<HealthGoalDb> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<double>? targetValue,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (targetValue != null) 'target_value': targetValue,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HealthGoalsCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<double>? targetValue,
    Value<DateTime>? startDate,
    Value<DateTime?>? endDate,
    Value<DateTime?>? createdAt,
    Value<int>? rowid,
  }) {
    return HealthGoalsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      targetValue: targetValue ?? this.targetValue,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<double>(targetValue.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HealthGoalsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('targetValue: $targetValue, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$HealthDatabase extends GeneratedDatabase {
  _$HealthDatabase(QueryExecutor e) : super(e);
  $HealthDatabaseManager get managers => $HealthDatabaseManager(this);
  late final $StepRecordsTable stepRecords = $StepRecordsTable(this);
  late final $WeightRecordsTable weightRecords = $WeightRecordsTable(this);
  late final $TemperatureRecordsTable temperatureRecords =
      $TemperatureRecordsTable(this);
  late final $ExerciseRecordsTable exerciseRecords = $ExerciseRecordsTable(
    this,
  );
  late final $HealthGoalsTable healthGoals = $HealthGoalsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    stepRecords,
    weightRecords,
    temperatureRecords,
    exerciseRecords,
    healthGoals,
  ];
}

typedef $$StepRecordsTableCreateCompanionBuilder =
    StepRecordsCompanion Function({
      required String id,
      required DateTime date,
      required int steps,
      Value<bool> isAutoSync,
      Value<DateTime?> createdAt,
      Value<int> rowid,
    });
typedef $$StepRecordsTableUpdateCompanionBuilder =
    StepRecordsCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<int> steps,
      Value<bool> isAutoSync,
      Value<DateTime?> createdAt,
      Value<int> rowid,
    });

class $$StepRecordsTableFilterComposer
    extends Composer<_$HealthDatabase, $StepRecordsTable> {
  $$StepRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAutoSync => $composableBuilder(
    column: $table.isAutoSync,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StepRecordsTableOrderingComposer
    extends Composer<_$HealthDatabase, $StepRecordsTable> {
  $$StepRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAutoSync => $composableBuilder(
    column: $table.isAutoSync,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StepRecordsTableAnnotationComposer
    extends Composer<_$HealthDatabase, $StepRecordsTable> {
  $$StepRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<bool> get isAutoSync => $composableBuilder(
    column: $table.isAutoSync,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$StepRecordsTableTableManager
    extends
        RootTableManager<
          _$HealthDatabase,
          $StepRecordsTable,
          StepRecordDb,
          $$StepRecordsTableFilterComposer,
          $$StepRecordsTableOrderingComposer,
          $$StepRecordsTableAnnotationComposer,
          $$StepRecordsTableCreateCompanionBuilder,
          $$StepRecordsTableUpdateCompanionBuilder,
          (
            StepRecordDb,
            BaseReferences<_$HealthDatabase, $StepRecordsTable, StepRecordDb>,
          ),
          StepRecordDb,
          PrefetchHooks Function()
        > {
  $$StepRecordsTableTableManager(_$HealthDatabase db, $StepRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StepRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StepRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StepRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> steps = const Value.absent(),
                Value<bool> isAutoSync = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StepRecordsCompanion(
                id: id,
                date: date,
                steps: steps,
                isAutoSync: isAutoSync,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required int steps,
                Value<bool> isAutoSync = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StepRecordsCompanion.insert(
                id: id,
                date: date,
                steps: steps,
                isAutoSync: isAutoSync,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StepRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$HealthDatabase,
      $StepRecordsTable,
      StepRecordDb,
      $$StepRecordsTableFilterComposer,
      $$StepRecordsTableOrderingComposer,
      $$StepRecordsTableAnnotationComposer,
      $$StepRecordsTableCreateCompanionBuilder,
      $$StepRecordsTableUpdateCompanionBuilder,
      (
        StepRecordDb,
        BaseReferences<_$HealthDatabase, $StepRecordsTable, StepRecordDb>,
      ),
      StepRecordDb,
      PrefetchHooks Function()
    >;
typedef $$WeightRecordsTableCreateCompanionBuilder =
    WeightRecordsCompanion Function({
      required String id,
      required DateTime date,
      required double weight,
      Value<DateTime?> createdAt,
      Value<int> rowid,
    });
typedef $$WeightRecordsTableUpdateCompanionBuilder =
    WeightRecordsCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<double> weight,
      Value<DateTime?> createdAt,
      Value<int> rowid,
    });

class $$WeightRecordsTableFilterComposer
    extends Composer<_$HealthDatabase, $WeightRecordsTable> {
  $$WeightRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WeightRecordsTableOrderingComposer
    extends Composer<_$HealthDatabase, $WeightRecordsTable> {
  $$WeightRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeightRecordsTableAnnotationComposer
    extends Composer<_$HealthDatabase, $WeightRecordsTable> {
  $$WeightRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$WeightRecordsTableTableManager
    extends
        RootTableManager<
          _$HealthDatabase,
          $WeightRecordsTable,
          WeightRecordDb,
          $$WeightRecordsTableFilterComposer,
          $$WeightRecordsTableOrderingComposer,
          $$WeightRecordsTableAnnotationComposer,
          $$WeightRecordsTableCreateCompanionBuilder,
          $$WeightRecordsTableUpdateCompanionBuilder,
          (
            WeightRecordDb,
            BaseReferences<
              _$HealthDatabase,
              $WeightRecordsTable,
              WeightRecordDb
            >,
          ),
          WeightRecordDb,
          PrefetchHooks Function()
        > {
  $$WeightRecordsTableTableManager(
    _$HealthDatabase db,
    $WeightRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeightRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeightRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeightRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> weight = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeightRecordsCompanion(
                id: id,
                date: date,
                weight: weight,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required double weight,
                Value<DateTime?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeightRecordsCompanion.insert(
                id: id,
                date: date,
                weight: weight,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WeightRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$HealthDatabase,
      $WeightRecordsTable,
      WeightRecordDb,
      $$WeightRecordsTableFilterComposer,
      $$WeightRecordsTableOrderingComposer,
      $$WeightRecordsTableAnnotationComposer,
      $$WeightRecordsTableCreateCompanionBuilder,
      $$WeightRecordsTableUpdateCompanionBuilder,
      (
        WeightRecordDb,
        BaseReferences<_$HealthDatabase, $WeightRecordsTable, WeightRecordDb>,
      ),
      WeightRecordDb,
      PrefetchHooks Function()
    >;
typedef $$TemperatureRecordsTableCreateCompanionBuilder =
    TemperatureRecordsCompanion Function({
      required String id,
      required DateTime date,
      required double temperature,
      Value<DateTime?> createdAt,
      Value<int> rowid,
    });
typedef $$TemperatureRecordsTableUpdateCompanionBuilder =
    TemperatureRecordsCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<double> temperature,
      Value<DateTime?> createdAt,
      Value<int> rowid,
    });

class $$TemperatureRecordsTableFilterComposer
    extends Composer<_$HealthDatabase, $TemperatureRecordsTable> {
  $$TemperatureRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TemperatureRecordsTableOrderingComposer
    extends Composer<_$HealthDatabase, $TemperatureRecordsTable> {
  $$TemperatureRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TemperatureRecordsTableAnnotationComposer
    extends Composer<_$HealthDatabase, $TemperatureRecordsTable> {
  $$TemperatureRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TemperatureRecordsTableTableManager
    extends
        RootTableManager<
          _$HealthDatabase,
          $TemperatureRecordsTable,
          TemperatureRecordDb,
          $$TemperatureRecordsTableFilterComposer,
          $$TemperatureRecordsTableOrderingComposer,
          $$TemperatureRecordsTableAnnotationComposer,
          $$TemperatureRecordsTableCreateCompanionBuilder,
          $$TemperatureRecordsTableUpdateCompanionBuilder,
          (
            TemperatureRecordDb,
            BaseReferences<
              _$HealthDatabase,
              $TemperatureRecordsTable,
              TemperatureRecordDb
            >,
          ),
          TemperatureRecordDb,
          PrefetchHooks Function()
        > {
  $$TemperatureRecordsTableTableManager(
    _$HealthDatabase db,
    $TemperatureRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TemperatureRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TemperatureRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TemperatureRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> temperature = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TemperatureRecordsCompanion(
                id: id,
                date: date,
                temperature: temperature,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required double temperature,
                Value<DateTime?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TemperatureRecordsCompanion.insert(
                id: id,
                date: date,
                temperature: temperature,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TemperatureRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$HealthDatabase,
      $TemperatureRecordsTable,
      TemperatureRecordDb,
      $$TemperatureRecordsTableFilterComposer,
      $$TemperatureRecordsTableOrderingComposer,
      $$TemperatureRecordsTableAnnotationComposer,
      $$TemperatureRecordsTableCreateCompanionBuilder,
      $$TemperatureRecordsTableUpdateCompanionBuilder,
      (
        TemperatureRecordDb,
        BaseReferences<
          _$HealthDatabase,
          $TemperatureRecordsTable,
          TemperatureRecordDb
        >,
      ),
      TemperatureRecordDb,
      PrefetchHooks Function()
    >;
typedef $$ExerciseRecordsTableCreateCompanionBuilder =
    ExerciseRecordsCompanion Function({
      required String id,
      required DateTime date,
      required String exerciseType,
      required int durationMinutes,
      Value<String?> note,
      Value<DateTime?> createdAt,
      Value<int> rowid,
    });
typedef $$ExerciseRecordsTableUpdateCompanionBuilder =
    ExerciseRecordsCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<String> exerciseType,
      Value<int> durationMinutes,
      Value<String?> note,
      Value<DateTime?> createdAt,
      Value<int> rowid,
    });

class $$ExerciseRecordsTableFilterComposer
    extends Composer<_$HealthDatabase, $ExerciseRecordsTable> {
  $$ExerciseRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseType => $composableBuilder(
    column: $table.exerciseType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExerciseRecordsTableOrderingComposer
    extends Composer<_$HealthDatabase, $ExerciseRecordsTable> {
  $$ExerciseRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseType => $composableBuilder(
    column: $table.exerciseType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExerciseRecordsTableAnnotationComposer
    extends Composer<_$HealthDatabase, $ExerciseRecordsTable> {
  $$ExerciseRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get exerciseType => $composableBuilder(
    column: $table.exerciseType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ExerciseRecordsTableTableManager
    extends
        RootTableManager<
          _$HealthDatabase,
          $ExerciseRecordsTable,
          ExerciseRecordDb,
          $$ExerciseRecordsTableFilterComposer,
          $$ExerciseRecordsTableOrderingComposer,
          $$ExerciseRecordsTableAnnotationComposer,
          $$ExerciseRecordsTableCreateCompanionBuilder,
          $$ExerciseRecordsTableUpdateCompanionBuilder,
          (
            ExerciseRecordDb,
            BaseReferences<
              _$HealthDatabase,
              $ExerciseRecordsTable,
              ExerciseRecordDb
            >,
          ),
          ExerciseRecordDb,
          PrefetchHooks Function()
        > {
  $$ExerciseRecordsTableTableManager(
    _$HealthDatabase db,
    $ExerciseRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> exerciseType = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseRecordsCompanion(
                id: id,
                date: date,
                exerciseType: exerciseType,
                durationMinutes: durationMinutes,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required String exerciseType,
                required int durationMinutes,
                Value<String?> note = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseRecordsCompanion.insert(
                id: id,
                date: date,
                exerciseType: exerciseType,
                durationMinutes: durationMinutes,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExerciseRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$HealthDatabase,
      $ExerciseRecordsTable,
      ExerciseRecordDb,
      $$ExerciseRecordsTableFilterComposer,
      $$ExerciseRecordsTableOrderingComposer,
      $$ExerciseRecordsTableAnnotationComposer,
      $$ExerciseRecordsTableCreateCompanionBuilder,
      $$ExerciseRecordsTableUpdateCompanionBuilder,
      (
        ExerciseRecordDb,
        BaseReferences<
          _$HealthDatabase,
          $ExerciseRecordsTable,
          ExerciseRecordDb
        >,
      ),
      ExerciseRecordDb,
      PrefetchHooks Function()
    >;
typedef $$HealthGoalsTableCreateCompanionBuilder =
    HealthGoalsCompanion Function({
      required String id,
      required String type,
      required double targetValue,
      required DateTime startDate,
      Value<DateTime?> endDate,
      Value<DateTime?> createdAt,
      Value<int> rowid,
    });
typedef $$HealthGoalsTableUpdateCompanionBuilder =
    HealthGoalsCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<double> targetValue,
      Value<DateTime> startDate,
      Value<DateTime?> endDate,
      Value<DateTime?> createdAt,
      Value<int> rowid,
    });

class $$HealthGoalsTableFilterComposer
    extends Composer<_$HealthDatabase, $HealthGoalsTable> {
  $$HealthGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HealthGoalsTableOrderingComposer
    extends Composer<_$HealthDatabase, $HealthGoalsTable> {
  $$HealthGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HealthGoalsTableAnnotationComposer
    extends Composer<_$HealthDatabase, $HealthGoalsTable> {
  $$HealthGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HealthGoalsTableTableManager
    extends
        RootTableManager<
          _$HealthDatabase,
          $HealthGoalsTable,
          HealthGoalDb,
          $$HealthGoalsTableFilterComposer,
          $$HealthGoalsTableOrderingComposer,
          $$HealthGoalsTableAnnotationComposer,
          $$HealthGoalsTableCreateCompanionBuilder,
          $$HealthGoalsTableUpdateCompanionBuilder,
          (
            HealthGoalDb,
            BaseReferences<_$HealthDatabase, $HealthGoalsTable, HealthGoalDb>,
          ),
          HealthGoalDb,
          PrefetchHooks Function()
        > {
  $$HealthGoalsTableTableManager(_$HealthDatabase db, $HealthGoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HealthGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HealthGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HealthGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> targetValue = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HealthGoalsCompanion(
                id: id,
                type: type,
                targetValue: targetValue,
                startDate: startDate,
                endDate: endDate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required double targetValue,
                required DateTime startDate,
                Value<DateTime?> endDate = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HealthGoalsCompanion.insert(
                id: id,
                type: type,
                targetValue: targetValue,
                startDate: startDate,
                endDate: endDate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HealthGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$HealthDatabase,
      $HealthGoalsTable,
      HealthGoalDb,
      $$HealthGoalsTableFilterComposer,
      $$HealthGoalsTableOrderingComposer,
      $$HealthGoalsTableAnnotationComposer,
      $$HealthGoalsTableCreateCompanionBuilder,
      $$HealthGoalsTableUpdateCompanionBuilder,
      (
        HealthGoalDb,
        BaseReferences<_$HealthDatabase, $HealthGoalsTable, HealthGoalDb>,
      ),
      HealthGoalDb,
      PrefetchHooks Function()
    >;

class $HealthDatabaseManager {
  final _$HealthDatabase _db;
  $HealthDatabaseManager(this._db);
  $$StepRecordsTableTableManager get stepRecords =>
      $$StepRecordsTableTableManager(_db, _db.stepRecords);
  $$WeightRecordsTableTableManager get weightRecords =>
      $$WeightRecordsTableTableManager(_db, _db.weightRecords);
  $$TemperatureRecordsTableTableManager get temperatureRecords =>
      $$TemperatureRecordsTableTableManager(_db, _db.temperatureRecords);
  $$ExerciseRecordsTableTableManager get exerciseRecords =>
      $$ExerciseRecordsTableTableManager(_db, _db.exerciseRecords);
  $$HealthGoalsTableTableManager get healthGoals =>
      $$HealthGoalsTableTableManager(_db, _db.healthGoals);
}
