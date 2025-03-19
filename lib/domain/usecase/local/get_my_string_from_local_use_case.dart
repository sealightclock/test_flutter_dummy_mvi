import 'package:test_flutter_dummy_mvi/data/local/my_string_shared_prefs_repository.dart';
import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';

/// Use Case: Retrieve the stored string from SharedPreferences.
class GetMyStringFromLocalUseCase {
  final MyStringSharedPrefsRepository repository;

  GetMyStringFromLocalUseCase({required this.repository});

  Future<MyStringEntity> execute() async => repository.getMyString();
}
