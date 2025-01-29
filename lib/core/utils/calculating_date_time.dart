import 'package:intl/intl.dart';

String calculateTimeInddmmmyyy (DateTime dateTime){
  return DateFormat("dd MMM yyyy").format(dateTime);
}