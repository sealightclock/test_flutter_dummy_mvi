import 'dart:async';

class MyStringBackendServerRepository {
  Future<String> getMyStringFromServer() async {
    await Future.delayed(Duration(seconds: 2));
    return 'Server Data: ${DateTime.now()}';
  }
}
