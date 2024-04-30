import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkCheck {
  static Future<bool> isConnected() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        print('NetworkCheck: Device is connected to the internet.');
        return true;
      } else {
        print('NetworkCheck: Device is not connected to the internet.');
        return false;
      }
    } catch (e) {
      print('NetworkCheck: Failed to check internet connectivity. Error: $e');
      return false;
    }
  }
}