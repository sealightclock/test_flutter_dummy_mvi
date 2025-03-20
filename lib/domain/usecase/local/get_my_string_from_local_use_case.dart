import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';

import '../../../data/repository/my_string_repository.dart';

/// Use Case: Retrieve the stored string from SharedPreferences.
class GetMyStringFromLocalUseCase {
  final MyStringRepository repository;

  GetMyStringFromLocalUseCase(this.repository);

  Future<MyStringEntity> execute() {
    return repository.getMyStringFromLocal();
  }
}
