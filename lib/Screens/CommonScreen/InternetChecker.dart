
import 'package:connectivity_plus/connectivity_plus.dart';

class getInternetConnectionChecker{

Future<bool> getInternetConnection() async{


final connectivityResult = await (Connectivity().checkConnectivity());
if (connectivityResult == ConnectivityResult.mobile) {
  // print("mobile");

  return true;

} else if (connectivityResult == ConnectivityResult.wifi) {
   //print("wifi");

  return true;
  // I am connected to a wifi network.
} else if (connectivityResult == ConnectivityResult.ethernet) {
  //  print("Ethernet");

  return true;
  // I am connected to a ethernet network.
} else if (connectivityResult == ConnectivityResult.vpn) {
  //  print("vpn");


  return true;
  // I am connected to a vpn network.
  // Note for iOS and macOS:
  // There is no separate network interface type for [vpn].
  // It returns [other] on any device (also simulator)
} else if (connectivityResult == ConnectivityResult.bluetooth) {
  //  print("bluetooth");
 

  return true;
  // I am connected to a bluetooth.
} else if (connectivityResult == ConnectivityResult.other) {
  //  print("other");


  return true;

  // I am connected to a network which is not in the above mentioned networks.
} else if (connectivityResult == ConnectivityResult.none) {
   print("none");

  return false;
  // I am not connected to any network.
}
else{


  return false;
}


  
  }





}