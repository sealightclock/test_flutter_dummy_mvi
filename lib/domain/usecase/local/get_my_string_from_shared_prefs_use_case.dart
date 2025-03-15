import '../../data/local/my_string_shared_prefs_repository.dart';
import '../../entity/my_string_entity.dart';

class GetMyStringFromSharedPrefsUseCase {
  final MyStringSharedPrefsRepository repository;

  GetMyStringFromSharedPrefsUseCase({required this.repository});

  Future<MyStringEntity> execute() async {
    return repository.getMyString();
  }
}
