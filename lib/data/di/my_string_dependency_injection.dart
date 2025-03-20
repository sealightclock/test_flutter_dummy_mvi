import 'package:test_flutter_dummy_mvi/data/remote/my_string_remote_data_source.dart';

import '../local/my_string_hive_data_source.dart';
import '../local/my_string_local_data_source.dart';
import '../local/my_string_shared_prefs_data_source.dart';
import '../remote/my_string_dio_data_source.dart';
import '../remote/my_string_http_data_source.dart';
import '../remote/my_string_simulator_data_source.dart';

enum LocalStore { sharedPrefs, hive }

MyStringLocalDataSource createLocalDataSource(LocalStore storeType) {
  switch (storeType) {
    case LocalStore.sharedPrefs:
      return MyStringSharedPrefsDataSource();
    case LocalStore.hive:
      return MyStringHiveDataSource();
  }
}

enum RemoteServer { simulator, dio, http }

MyStringRemoteDataSource createRemoteDataSource(RemoteServer serverType) {
  switch (serverType) {
    case RemoteServer.simulator:
      return MyStringSimulatorDataSource();
    case RemoteServer.dio:
      return MyStringDioDataSource();
    case RemoteServer.http:
      return MyStringHttpDataSource();
  }
}

// !!! TODO: Change these values if needed:
final storeTypeSelected = LocalStore.hive;
final serverTypeSelected = RemoteServer.http;
