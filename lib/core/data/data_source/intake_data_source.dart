import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:beFit/core/data/dbo/intake_dbo.dart';
import 'package:beFit/core/data/dbo/intake_type_dbo.dart';

class IntakeDataSource {
  final log = Logger('IntakeDataSource');
  final Box<IntakeDBO> _intakeBox;

  IntakeDataSource(this._intakeBox);

  Future<void> addIntake(IntakeDBO intakeDBO) async {
    log.fine('Adding new intake item to db');
    _intakeBox.add(intakeDBO);
  }

  Future<void> deleteIntakeFromId(String intakeId) async {
    log.fine('Deleting intake item from db');
    _intakeBox.values
        .where((dbo) => dbo.id == intakeId)
        .toList()
        .forEach((element) {
      element.delete();
    });
  }

  //Future<IntakeDBO?> updateIntake(String intakeId, Map<String, dynamic> fields) async {
  //  log.fine('Updating intake $intakeId with fields ${fields.toString()} in db');
  //  var intakeObject = _intakeBox.values.indexed
  //    .where((indexedDbo) => indexedDbo.$2.id == intakeId).firstOrNull;
  //  if(intakeObject == null) {
  //    log.fine('Cannot update intake $intakeId as it is non existent');
  //    return null;
  //  }
  //  intakeObject.$2.amount = fields['amount'] ?? intakeObject.$2.amount;
  //  _intakeBox.putAt(intakeObject.$1, intakeObject.$2);
  //  return _intakeBox.getAt(intakeObject.$1);
  //}









  Future<IntakeDBO?> updateIntake(String intakeId, Map<String, dynamic> fields) async {
  log.fine('Updating intake $intakeId with fields ${fields.toString()} in db');

  // Convert the intakeBox values to a list so we can access both index and value
  final intakeList = _intakeBox.values.toList();

  // Find the index of the intake with the matching intakeId
  final intakeIndex = intakeList.indexWhere((dbo) => dbo.id == intakeId);

  // If intake is not found, log the message and return null
  if (intakeIndex == -1) {
    log.fine('Cannot update intake $intakeId as it is non-existent');
    return null;
  }

  // Retrieve the intake object at the found index
  var intakeObject = intakeList[intakeIndex];
  
  // Update the intake object's fields with provided values
  intakeObject.amount = fields['amount'] ?? intakeObject.amount;

  // Save the updated intake object back to the box
  _intakeBox.putAt(intakeIndex, intakeObject);

  // Return the updated intake object
  return intakeObject;
}

















  Future<IntakeDBO?> getIntakeById(String intakeId) async {
    return _intakeBox.values.firstWhereOrNull(
            (intake) => intake.id == intakeId
    );
  }

  Future<List<IntakeDBO>> getAllIntakesByDate(
      IntakeTypeDBO intakeType, DateTime dateTime) async {
    return _intakeBox.values
        .where((intake) =>
            DateUtils.isSameDay(dateTime, intake.dateTime) &&
            intake.type == intakeType)
        .toList();
  }

  Future<List<IntakeDBO>> getRecentlyAddedIntake({int number = 100}) async {
    final intakeList = _intakeBox.values.toList();

    //  sort list by date and filter unique intake
    intakeList
        .sort((a, b) => a.dateTime.compareTo(b.dateTime));

    final filterCodes = <String>{};
    final uniqueIntake = intakeList
        .where((intake) =>
            filterCodes.add(intake.meal.code ?? intake.meal.name ?? ""))
        .toList();

    return uniqueIntake.take(number).toList();
  }
}
