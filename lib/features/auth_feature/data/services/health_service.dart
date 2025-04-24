import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class HealthService {
  final Health health = Health();

  static const List<HealthDataType> _dataTypes = [
    HealthDataType.STEPS,
    HealthDataType.WATER,
    HealthDataType.WEIGHT,
    HealthDataType.HEIGHT,
  ];

  static const List<HealthDataAccess> _dataAccess = [
    HealthDataAccess.READ,
    HealthDataAccess.WRITE,
  ];

  Future<bool> requestAuthorization() async {
    try {
      print('Starting health authorization request...');
      
      // Check if device supports Health data
      print('Checking existing health permissions...');
      bool? hasPermissionsResult;
      try {
        hasPermissionsResult = await health.hasPermissions(_dataTypes, permissions: _dataAccess);
        print('hasPermissions result: $hasPermissionsResult');
      } catch (e) {
        print('Error checking permissions: $e');
        hasPermissionsResult = false;
      }
      
      bool hasPermissions = hasPermissionsResult ?? false;
      print('Health data availability: $hasPermissions');
      
      if (!hasPermissions) {
        print('No existing permissions, requesting new permissions...');
        bool? permissionsResult;
        try {
          permissionsResult = await health.requestAuthorization(_dataTypes, permissions: _dataAccess);
          print('requestAuthorization result: $permissionsResult');
        } catch (e) {
          print('Error requesting authorization: $e');
          if (e.toString().contains('Error in HealthKit')) {
            print('HealthKit error - please ensure HealthKit is enabled in Xcode capabilities');
          }
          return false;
        }
        
        if (permissionsResult == true) {
          print('Permissions granted, verifying data access...');
          // Verify that we can actually read the data
          final now = DateTime.now();
          final yesterday = now.subtract(const Duration(days: 1));
          try {
            print('Attempting to read steps data...');
            final steps = await health.getHealthDataFromTypes(
              startTime: yesterday,
              endTime: now,
              types: [HealthDataType.STEPS],
            );
            print('Successfully read steps data: ${steps.length} records found');
            return true;
          } catch (e) {
            print('Failed to read health data after permissions were granted:');
            print('Error type: ${e.runtimeType}');
            print('Error details: $e');
            return false;
          }
        }
        return permissionsResult ?? false;
      } else {
        print('Health permissions already granted, verifying access...');
        // Verify existing access
        try {
          final now = DateTime.now();
          final yesterday = now.subtract(const Duration(days: 1));
          final steps = await health.getHealthDataFromTypes(
            startTime: yesterday,
            endTime: now,
            types: [HealthDataType.STEPS],
          );
          print('Successfully verified existing access: ${steps.length} records found');
          return true;
        } catch (e) {
          print('Failed to verify existing access:');
          print('Error type: ${e.runtimeType}');
          print('Error details: $e');
          return false;
        }
      }
    } catch (e) {
      print('Critical error in requestAuthorization:');
      print('Error type: ${e.runtimeType}');
      print('Error details: $e');
      if (e.toString().contains('Error in HealthKit')) {
        print('HealthKit error - please ensure HealthKit is enabled in Xcode capabilities');
      }
      return false;
    }
  }

  Future<void> fetchHealthData() async {
    try {
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));

      print('Fetching health data...');
      
      // Fetch steps
      final steps = await health.getHealthDataFromTypes(
        startTime: yesterday,
        endTime: now,
        types: [HealthDataType.STEPS],
      );
      print('Steps data: ${steps.length} records found');
      for (var step in steps) {
        print('Steps record: ${step.value} at ${step.dateFrom}');
      }
      // Fetch water
      final water = await health.getHealthDataFromTypes(
        startTime: yesterday,
        endTime: now,
        types: [HealthDataType.WATER],
      );
      print('Water data: ${water.length} records found');
      for (var w in water) {
        print('Water record: ${w.value} ml at ${w.dateFrom}');
      }

      // Additional data types can be fetched here...
      
    } catch (e) {
      print('Error fetching health data: $e');
      rethrow;
    }
  }
} 