# test_flutter_dummy_mvi

This is a dummy Flutter app with MVI architecture, for testing and learning purposes.

It handles a single string, 'MyString'. The file structure is as follows:

presentation/
    view/
        my_string_home_screen.dart
    intent/
        my_string_intent.dart
    viewmodel/
        my_string_viewmodel.dart
domain/
    entity/
        my_string_entity.dart
    usecase/
        local/
            get_my_string_from_local_use_case.dart
            store_my_string_to_local_use_case.dart
        remote/
            get_my_string_from_remote_use_case.dart
data/
    repository/
        my_string_repository.dart
        my_string_repository_impl.dart
    local/
        my_string_local_data_source.dart
        my_string_shared_prefs_data_source.dart
        my_string_hive_data_source.dart
    remote/
        my_string_dio_api.dart
        my_string_http_api.dart
        my_string_remote_data_source.dart
        my_string_simulator_data_source.dart
        my_string_dio_data_source.dart
        my_string_http_data_source.dart
    di/
        my_string_dependency_injection.dart

which reflects the chosen design pattern MVI.