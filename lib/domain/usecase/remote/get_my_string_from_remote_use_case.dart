import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';

import '../../../data/repository/my_string_repository.dart';

/// Use Case: Retrieve the latest string from the backend server.
class GetMyStringFromRemoteUseCase {
  final MyStringRepository repository;

  GetMyStringFromRemoteUseCase({required this.repository});

  // execute() is commonly used in Use Cases to execute the use case.
  // Do not use "await" if we are not modifying the value:
  Future<MyStringEntity> execute() async => repository.getMyStringFromRemote();
}
