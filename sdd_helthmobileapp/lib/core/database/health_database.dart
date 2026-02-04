import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'health_database.g.dart';

/// 歩数テーブル
@DataClassName('StepRecordDb')
class StepRecords extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get steps => integer()();
  BoolColumn get isAutoSync => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 体重テーブル
@DataClassName('WeightRecordDb')
class WeightRecords extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  RealColumn get weight => real()();
  DateTimeColumn get createdAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 体温テーブル
@DataClassName('TemperatureRecordDb')
class TemperatureRecords extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  RealColumn get temperature => real()();
  DateTimeColumn get createdAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 運動テーブル
@DataClassName('ExerciseRecordDb')
class ExerciseRecords extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get exerciseType => text()();
  IntColumn get durationMinutes => integer()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 目標テーブル
@DataClassName('HealthGoalDb')
class HealthGoals extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()(); // steps, weight, exercise
  RealColumn get targetValue => real()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [
  StepRecords,
  WeightRecords,
  TemperatureRecords,
  ExerciseRecords,
  HealthGoals,
])
class HealthDatabase extends _$HealthDatabase {
  HealthDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // 歩数CRUD
  Future<List<StepRecordDb>> getAllStepRecords() => select(stepRecords).get();
  
  Stream<List<StepRecordDb>> watchStepRecords() => select(stepRecords).watch();
  
  Future<List<StepRecordDb>> getStepRecordsByDateRange(DateTime start, DateTime end) {
    return (select(stepRecords)
          ..where((t) => t.date.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
  }
  
  Future<int> insertStepRecord(StepRecordsCompanion record) =>
      into(stepRecords).insert(record);
  
  Future<bool> updateStepRecord(StepRecordsCompanion record) =>
      update(stepRecords).replace(record);
  
  Future<int> deleteStepRecord(String id) =>
      (delete(stepRecords)..where((t) => t.id.equals(id))).go();

  // 体重CRUD
  Future<List<WeightRecordDb>> getAllWeightRecords() => select(weightRecords).get();
  
  Stream<List<WeightRecordDb>> watchWeightRecords() => select(weightRecords).watch();
  
  Future<List<WeightRecordDb>> getWeightRecordsByDateRange(DateTime start, DateTime end) {
    return (select(weightRecords)
          ..where((t) => t.date.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
  }
  
  Future<int> insertWeightRecord(WeightRecordsCompanion record) =>
      into(weightRecords).insert(record);
  
  Future<bool> updateWeightRecord(WeightRecordsCompanion record) =>
      update(weightRecords).replace(record);
  
  Future<int> deleteWeightRecord(String id) =>
      (delete(weightRecords)..where((t) => t.id.equals(id))).go();

  // 体温CRUD
  Future<List<TemperatureRecordDb>> getAllTemperatureRecords() =>
      select(temperatureRecords).get();
  
  Stream<List<TemperatureRecordDb>> watchTemperatureRecords() =>
      select(temperatureRecords).watch();
  
  Future<List<TemperatureRecordDb>> getTemperatureRecordsByDateRange(
      DateTime start, DateTime end) {
    return (select(temperatureRecords)
          ..where((t) => t.date.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
  }
  
  Future<int> insertTemperatureRecord(TemperatureRecordsCompanion record) =>
      into(temperatureRecords).insert(record);
  
  Future<bool> updateTemperatureRecord(TemperatureRecordsCompanion record) =>
      update(temperatureRecords).replace(record);
  
  Future<int> deleteTemperatureRecord(String id) =>
      (delete(temperatureRecords)..where((t) => t.id.equals(id))).go();

  // 運動CRUD
  Future<List<ExerciseRecordDb>> getAllExerciseRecords() =>
      select(exerciseRecords).get();
  
  Stream<List<ExerciseRecordDb>> watchExerciseRecords() =>
      select(exerciseRecords).watch();
  
  Future<List<ExerciseRecordDb>> getExerciseRecordsByDateRange(
      DateTime start, DateTime end) {
    return (select(exerciseRecords)
          ..where((t) => t.date.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
  }
  
  Future<int> insertExerciseRecord(ExerciseRecordsCompanion record) =>
      into(exerciseRecords).insert(record);
  
  Future<bool> updateExerciseRecord(ExerciseRecordsCompanion record) =>
      update(exerciseRecords).replace(record);
  
  Future<int> deleteExerciseRecord(String id) =>
      (delete(exerciseRecords)..where((t) => t.id.equals(id))).go();

  // 目標CRUD
  Future<List<HealthGoalDb>> getAllGoals() => select(healthGoals).get();
  
  Stream<List<HealthGoalDb>> watchGoals() => select(healthGoals).watch();
  
  Future<HealthGoalDb?> getGoalByType(String type) =>
      (select(healthGoals)..where((t) => t.type.equals(type))).getSingleOrNull();
  
  Future<int> insertGoal(HealthGoalsCompanion goal) =>
      into(healthGoals).insert(goal);
  
  Future<bool> updateGoal(HealthGoalsCompanion goal) =>
      update(healthGoals).replace(goal);
  
  Future<int> deleteGoal(String id) =>
      (delete(healthGoals)..where((t) => t.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'health_database.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
