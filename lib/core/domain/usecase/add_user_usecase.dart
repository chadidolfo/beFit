import 'package:beFit/core/data/repository/user_repository.dart';
import 'package:beFit/core/domain/entity/user_entity.dart';

class AddUserUsecase {
  final UserRepository _userRepository;

  AddUserUsecase(this._userRepository);

  Future<void> addUser(UserEntity userEntity) async {
    return await _userRepository.updateUserData(userEntity);
  }
}
