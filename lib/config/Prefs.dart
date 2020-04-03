import 'package:coronavirus/helpers/PreferencesHelper.dart';

import 'Cons.dart';

class Prefs {
  static Future<String> get Country async {
    var result = await PreferencesHelper.getString(Const.Country);
    if(result == null)
    {
      await setCountry("Turkey");
    }
    return PreferencesHelper.getString(Const.Country);
  }
  static Future setCountry(String value) async=> 
    PreferencesHelper.setString(Const.Country, value);
  static Future<String> get Language async => 
    PreferencesHelper.getString(Const.Language);
  static Future setLanguage(String value) async{
    var result = await PreferencesHelper.getString(Const.Language);
    if(result == null)
    {
      await setCountry("en_US");
    }
    return PreferencesHelper.getString(Const.Language);
  }
  static Future<void> clear() async {
    await Future.wait(<Future>[
      setCountry("Turkey"),
      setLanguage("en_US")
    ]);
  }
}