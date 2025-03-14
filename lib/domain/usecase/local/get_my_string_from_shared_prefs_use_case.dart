import '../../data/local/my_string_shared_prefs_repository.dart';

class GetMyStringFromSharedPrefsUseCase {
  final MyStringSharedPrefsRepository repository;

  GetMyStringFromSharedPrefsUseCase(this.repository);

  Future<String> execute() async {
    return repository.getMyString();
  }
}
