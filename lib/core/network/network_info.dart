import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  Future<bool> get isConnected async => await _checkInternetConnect();

  _checkInternetConnect() async {
    final connectResult = await Connectivity().checkConnectivity();

    if (connectResult == ConnectivityResult.mobile ||
        connectResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
