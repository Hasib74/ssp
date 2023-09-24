import 'package:connectivity_plus/connectivity_plus.dart';

class AppCheckInternet {
  static Future<bool> check() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    print("Internet connection result : ${connectivityResult}");

    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      return true;
    } else {
      // I am connected to a wifi network.
      return false;
    }
  }
}
