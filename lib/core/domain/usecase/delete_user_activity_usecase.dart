import 'package:beFit/core/data/repository/user_activity_repository.dart';
import 'package:beFit/core/domain/entity/user_activity_entity.dart';

class DeleteUserActivityUsecase {
  final UserActivityRepository _userActivityRepository;

  DeleteUserActivityUsecase(this._userActivityRepository);

  Future<void> deleteUserActivity(UserActivityEntity activityEntity) async {
    await _userActivityRepository.deleteUserActivity(activityEntity);
  }
}
