import 'package:coronavirus/helpers/DateHelper.dart';
import 'package:coronavirus/config/Prefs.dart';
import 'package:coronavirus/models/AffectedCountries.dart';
import 'package:coronavirus/models/CasesByCountry.dart';
import 'package:coronavirus/models/CountryHistory.dart';
import 'package:coronavirus/models/CountryHistoryByDate.dart';
import 'package:coronavirus/models/CountryStats.dart';
import 'package:coronavirus/models/WorldStats.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ApiService
{
  static const String BASE_URL = "coronavirus-monitor.p.rapidapi.com";
  static const String SECONDARY_API_BASE_URL = "covid-193.p.rapidapi.com";
  static Map<String,String> headers = {
    "x-rapidapi-host": "coronavirus-monitor.p.rapidapi.com",
    "x-rapidapi-key": "e93618e187msh5e57d510c97854dp1b674ejsn656d3cfab530"
  };
  static Map<String, String> secondary_headers = {
    "x-rapidapi-host": "covid-193.p.rapidapi.com",
	  "x-rapidapi-key": "e93618e187msh5e57d510c97854dp1b674ejsn656d3cfab530"
  };
  static AffectedCountries countriesResult;
  static CasesByCountry casesByCountryResult; 
  static Future<AffectedCountries> getCountries() async
  {
    if(countriesResult == null)
    {
      http.Response res = await getRequest(endpoint: "coronavirus/affected.php");
      var result = AffectedCountries.fromJson(json.decode(res.body));
      countriesResult = result;
      result.countries.sort();
    }
    return countriesResult;
  }

  static Future<List<String>> search(String search) async {
    await getCountries();
    var list = countriesResult.countries.where((x)=>x.contains(search)).toList();
    return list;
  }

  static Future<CountryStats> getCountryInfo(String country) async
  {
    var params = {
      "country" : country
    };
    http.Response res = await getRequest(endpoint: "coronavirus/latest_stat_by_country.php", params: params);
    CountryStats result = CountryStats.fromJson(json.decode(res.body));
    return result;
  }
  
  static Future<CountryStats> getSavedCountryInfo() async
  {
    var country = await Prefs.Country;
    var result = await getCountryInfo(country);
    return result;
  }

  static Future<WorldStats> getWorldStats() async
  {
    http.Response res = await getRequest(endpoint: "coronavirus/worldstat.php");
    WorldStats result = WorldStats.fromJson(json.decode(res.body));
    return result;
  }

  static Future<CountryHistoryByDate> getCountryHistoryByDate({String country, DateTime date, bool isSecondary = true}) async
  {
    String formatted = DateHelper.convertDateToParam(date);
    if(country == null)
    {
        country = await Prefs.Country;
    }
    var params = {
      "country" : country,
      "day" : formatted
    };
    http.Response res = await getRequest(endpoint: "history", params: params, isSecondary: true);
    CountryHistoryByDate result = CountryHistoryByDate.fromJson(json.decode(res.body));
    return result;
  }
  
  static Future<CountryHistory> getCountryHistory(String country) async
  {
    var params = {
      "country" : country
    };
    http.Response res = await getRequest(endpoint: "coronavirus/cases_by_particular_country.php", params: params);
    CountryHistory result = CountryHistory.fromJson(json.decode(res.body));
    return result;
  }
  
  
  static Future<List<CountriesStat>> getCasesByCountry({String search}) async
  {
    if(casesByCountryResult == null)
    {
      http.Response res = await getRequest(endpoint: "coronavirus/cases_by_country.php");
      var result = CasesByCountry.fromJson(json.decode(res.body));
      casesByCountryResult = result;
    }
    var parsedDate = DateHelper.parseDate(casesByCountryResult.statisticTakenAt);
    if(parsedDate.add(Duration(hours: 1)).compareTo(DateTime.now()) < 0)
    {
      http.Response res = await getRequest(endpoint: "coronavirus/cases_by_country.php");
      var result = CasesByCountry.fromJson(json.decode(res.body));
      casesByCountryResult = result;
    }
    if(search != null)
    {
      List<CountriesStat> list = casesByCountryResult.stats.where((x) => x.countryName.contains(search)).toList();
      return list;
    }
    return casesByCountryResult.stats;
  }
  
  static Future<http.Response> getRequest({String endpoint, params, bool isSecondary = false}) async
  {
    var url;
    var response;
    if(isSecondary == false)
    {
      url = Uri.https(BASE_URL, endpoint, params);
      response = await http.get(url, headers: headers);
    }
    else{
      url = Uri.https(SECONDARY_API_BASE_URL, endpoint, params);
      response = await http.get(url, headers: secondary_headers);
    }
      if(response.statusCode != 200)
      {
        throw new Exception("Error when calling api endpoint");
      }
      return response;
  }
}