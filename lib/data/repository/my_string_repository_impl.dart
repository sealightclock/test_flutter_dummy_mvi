import 'package:test_flutter_dummy_mvi/domain/entity/my_string_entity.dart';

import '../local/my_string_local_data_source.dart';
import '../remote/my_string_remote_data_source.dart';
import 'my_string_repository.dart';

class MyStringRepositoryImpl implements MyStringRepository {
  late final MyStringLocalDataSource localDataSource;
  late final MyStringRemoteDataSource remoteDataSource;

  MyStringRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<MyStringEntity> getMyStringFromLocal() {
    return localDataSource.getMyString();
  }

  @override
  Future<void> storeMyStringToLocal(MyStringEntity value) async {
    localDataSource.storeMyString(value);
  }

  @override
  Future<MyStringEntity> getMyStringFromRemote() {
    return remoteDataSource.getMyString();
  }
}
