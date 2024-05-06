import 'package:fluttertoast/fluttertoast.dart';
import '../styles/colors.dart';

showMessage(String message, bool good) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 4,
    backgroundColor: good ? green : red,
    textColor: lightGrey,
    fontSize: 16,
  );
}
