
import 'package:flutter/services.dart';

class Constant {
  static const String apiVersion = "v1";
  static const bool showLog = true;
  static const bool appUpdate = true;
  static const String googleApiKey = "AIzaSyDrlH7s5ZmmOU14mjEYjccw65zN5nFmt90";
  static const String countryCode = "countryCode";
  static const String STRIPE_SECRET = "sk_test_51N00U8FFReMpJzWzW0k62c5BgKrjWNJaFnu3DHoO8PUOKie0XyHlJBwVKQaLPsORqJ9udcg2RDWNlbqExcrDxecF00uNWboKYU";
}

class NumericInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-numeric characters from the new value
    String filteredValue = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Return the updated value with the numeric characters only
    return TextEditingValue(
        text: filteredValue,
        selection: TextSelection.collapsed(offset: filteredValue.length),
       );
  }
}
