import 'package:flutter/widgets.dart';

class CountryCode 
{
  static String getCountryCode(String name)
  {
    Locale locale = Locale.fromSubtags(scriptCode: name);
    return locale.countryCode;
  }
}