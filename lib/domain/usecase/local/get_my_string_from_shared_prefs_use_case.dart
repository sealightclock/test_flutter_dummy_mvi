import 'package:test_flutter_dummy_mvi/data/local/my_string_shared_prefs_repository.dart';
import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';

class GetMyStringFromSharedPrefsUseCase {
  final MyStringSharedPrefsRepository repository;

  GetMyStringFromSharedPrefsUseCase({required this.repository});

  Future<MyStringEntity> execute() async {
    return repository.getMyString();
  }
}
