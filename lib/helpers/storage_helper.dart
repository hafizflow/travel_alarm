import 'package:get_storage/get_storage.dart';
import '../models/alarm_model.dart';

class StorageHelper {
  static final StorageHelper _instance = StorageHelper._internal();
  factory StorageHelper() => _instance;
  StorageHelper._internal();

  final GetStorage _box = GetStorage();

  // Keys
  static const String _onboardingKey = 'onboarding_completed';
  static const String _alarmsKey = 'alarms';
  static const String _locationKey = 'location';

  // Initialize storage
  Future<void> initialize() async {
    await GetStorage.init();
  }

  // Onboarding
  bool get hasCompletedOnboarding => _box.read(_onboardingKey) ?? false;

  Future<void> setOnboardingCompleted() async {
    await _box.write(_onboardingKey, true);
  }

  // Location
  String? get savedLocation => _box.read(_locationKey);

  Future<void> saveLocation(String location) async {
    await _box.write(_locationKey, location);
  }

  // Alarms
  List<AlarmModel> getAlarms() {
    final List<dynamic>? alarmsJson = _box.read(_alarmsKey);
    if (alarmsJson == null) return [];

    return alarmsJson
        .map((json) => AlarmModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveAlarms(List<AlarmModel> alarms) async {
    final alarmsJson = alarms.map((alarm) => alarm.toJson()).toList();
    await _box.write(_alarmsKey, alarmsJson);
  }

  Future<void> addAlarm(AlarmModel alarm) async {
    final alarms = getAlarms();
    alarms.add(alarm);
    await saveAlarms(alarms);
  }

  Future<void> updateAlarm(AlarmModel updatedAlarm) async {
    final alarms = getAlarms();
    final index = alarms.indexWhere((alarm) => alarm.id == updatedAlarm.id);
    if (index != -1) {
      alarms[index] = updatedAlarm;
      await saveAlarms(alarms);
    }
  }

  Future<void> deleteAlarm(String alarmId) async {
    final alarms = getAlarms();
    alarms.removeWhere((alarm) => alarm.id == alarmId);
    await saveAlarms(alarms);
  }

  // Clear all data
  Future<void> clearAll() async {
    await _box.erase();
  }
}
