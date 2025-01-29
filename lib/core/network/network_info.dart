import 'package:connectivity_plus/connectivity_plus.dart';

// For checking internet connectivity
abstract interface class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImp implements NetworkInfo {
  Connectivity connectivity;

  NetworkInfoImp(this.connectivity);

  ///checks internet is connected or not
  ///returns [true] if internet is connected
  ///else it will return [false]
  @override
  Future<bool> isConnected() async {
    final connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      // The app is connected to a mobile network.
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      // The app is connected to a WiFi network.
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      // The app is connected to an ethernet network.
      return true;
    } 
    return false;
  }
}
