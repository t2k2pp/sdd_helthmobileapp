import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/database/health_database.dart';
import '../../domain/entities/step_record.dart' as entity;
import '../../domain/entities/weight_record.dart' as entity;
import '../../domain/entities/temperature_record.dart' as entity;
import '../../domain/entities/exercise_record.dart' as entity;

/// ローカルDBへのデータアクセスを担当
class HealthLocalDatasource {
  final HealthDatabase _db;
  final _uuid = const Uuid();

  HealthLocalDatasource(this._db);

  // ========== 歩数 ==========

  Future<List<entity.StepRecord>> getAllStepRecords() async {
    final records = await _db.getAllStepRecords();
    return records.map(_mapToStepEntity).toList();
  }

  Stream<List<entity.StepRecord>> watchStepRecords() {
    return _db.watchStepRecords().map(
          (records) => records.map(_mapToStepEntity).toList(),
        );
  }

  Future<List<entity.StepRecord>> getStepRecordsByDateRange(
      DateTime start, DateTime end) async {
    final records = await _db.getStepRecordsByDateRange(start, end);
    return records.map(_mapToStepEntity).toList();
  }

  Future<void> saveStepRecord(entity.StepRecord record) async {
    final companion = StepRecordsCompanion(
      id: Value(record.id.isEmpty ? _uuid.v4() : record.id),
      date: Value(record.date),
      steps: Value(record.steps),
      isAutoSync: Value(record.isAutoSync),
      createdAt: Value(record.createdAt ?? DateTime.now()),
    );
    await _db.insertStepRecord(companion);
  }

  Future<void> deleteStepRecord(String id) async {
    await _db.deleteStepRecord(id);
  }

  entity.StepRecord _mapToStepEntity(StepRecordDb record) {
    return entity.StepRecord(
      id: record.id,
      date: record.date,
      steps: record.steps,
      isAutoSync: record.isAutoSync,
      createdAt: record.createdAt,
    );
  }

  // ========== 体重 ==========

  Future<List<entity.WeightRecord>> getAllWeightRecords() async {
    final records = await _db.getAllWeightRecords();
    return records.map(_mapToWeightEntity).toList();
  }

  Stream<List<entity.WeightRecord>> watchWeightRecords() {
    return _db.watchWeightRecords().map(
          (records) => records.map(_mapToWeightEntity).toList(),
        );
  }

  Future<List<entity.WeightRecord>> getWeightRecordsByDateRange(
      DateTime start, DateTime end) async {
    final records = await _db.getWeightRecordsByDateRange(start, end);
    return records.map(_mapToWeightEntity).toList();
  }

  Future<void> saveWeightRecord(entity.WeightRecord record) async {
    final companion = WeightRecordsCompanion(
      id: Value(record.id.isEmpty ? _uuid.v4() : record.id),
      date: Value(record.date),
      weight: Value(record.weight),
      createdAt: Value(record.createdAt ?? DateTime.now()),
    );
    await _db.insertWeightRecord(companion);
  }

  Future<void> deleteWeightRecord(String id) async {
    await _db.deleteWeightRecord(id);
  }

  entity.WeightRecord _mapToWeightEntity(WeightRecordDb record) {
    return entity.WeightRecord(
      id: record.id,
      date: record.date,
      weight: record.weight,
      createdAt: record.createdAt,
    );
  }

  // ========== 体温 ==========

  Future<List<entity.TemperatureRecord>> getAllTemperatureRecords() async {
    final records = await _db.getAllTemperatureRecords();
    return records.map(_mapToTemperatureEntity).toList();
  }

  Stream<List<entity.TemperatureRecord>> watchTemperatureRecords() {
    return _db.watchTemperatureRecords().map(
          (records) => records.map(_mapToTemperatureEntity).toList(),
        );
  }

  Future<List<entity.TemperatureRecord>> getTemperatureRecordsByDateRange(
      DateTime start, DateTime end) async {
    final records = await _db.getTemperatureRecordsByDateRange(start, end);
    return records.map(_mapToTemperatureEntity).toList();
  }

  Future<void> saveTemperatureRecord(entity.TemperatureRecord record) async {
    final companion = TemperatureRecordsCompanion(
      id: Value(record.id.isEmpty ? _uuid.v4() : record.id),
      date: Value(record.date),
      temperature: Value(record.temperature),
      createdAt: Value(record.createdAt ?? DateTime.now()),
    );
    await _db.insertTemperatureRecord(companion);
  }

  Future<void> deleteTemperatureRecord(String id) async {
    await _db.deleteTemperatureRecord(id);
  }

  entity.TemperatureRecord _mapToTemperatureEntity(TemperatureRecordDb record) {
    return entity.TemperatureRecord(
      id: record.id,
      date: record.date,
      temperature: record.temperature,
      createdAt: record.createdAt,
    );
  }

  // ========== 運動 ==========

  Future<List<entity.ExerciseRecord>> getAllExerciseRecords() async {
    final records = await _db.getAllExerciseRecords();
    return records.map(_mapToExerciseEntity).toList();
  }

  Stream<List<entity.ExerciseRecord>> watchExerciseRecords() {
    return _db.watchExerciseRecords().map(
          (records) => records.map(_mapToExerciseEntity).toList(),
        );
  }

  Future<List<entity.ExerciseRecord>> getExerciseRecordsByDateRange(
      DateTime start, DateTime end) async {
    final records = await _db.getExerciseRecordsByDateRange(start, end);
    return records.map(_mapToExerciseEntity).toList();
  }

  Future<void> saveExerciseRecord(entity.ExerciseRecord record) async {
    final companion = ExerciseRecordsCompanion(
      id: Value(record.id.isEmpty ? _uuid.v4() : record.id),
      date: Value(record.date),
      exerciseType: Value(record.exerciseType),
      durationMinutes: Value(record.durationMinutes),
      note: Value(record.note),
      createdAt: Value(record.createdAt ?? DateTime.now()),
    );
    await _db.insertExerciseRecord(companion);
  }

  Future<void> deleteExerciseRecord(String id) async {
    await _db.deleteExerciseRecord(id);
  }

  entity.ExerciseRecord _mapToExerciseEntity(ExerciseRecordDb record) {
    return entity.ExerciseRecord(
      id: record.id,
      date: record.date,
      exerciseType: record.exerciseType,
      durationMinutes: record.durationMinutes,
      note: record.note,
      createdAt: record.createdAt,
    );
  }
}
