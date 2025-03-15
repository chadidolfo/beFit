import 'package:beFit/core/data/data_source/physical_activity_data_source.dart';
import 'package:beFit/core/domain/entity/physical_activity_entity.dart';

class PhysicalActivityRepository {
  final PhysicalActivityDataSource _physicalActivityDataSource;

  PhysicalActivityRepository(this._physicalActivityDataSource);

  Future<List<PhysicalActivityEntity>> getAllPhysicalActivities() async {
    final physicalActivitiesDBOList =
        _physicalActivityDataSource.getPhysicalActivityList();
    return physicalActivitiesDBOList
        .map((dbo) => PhysicalActivityEntity.fromPhysicalActivityDBO(dbo))
        .toList();
  }
}
