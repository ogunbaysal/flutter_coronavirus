import 'StatsByCountry.dart';

class CountryHistory {
  String country;
  List<StatsByCountry> stats;
  
  CountryHistory({this.country, this.stats});
  
  CountryHistory.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    if (json['stat_by_country'] != null) {
      stats = new List<StatsByCountry>();
      json['stat_by_country'].forEach((v) {
        stats.add(new StatsByCountry.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    if (this.stats != null) {
      data['stat_by_country'] =
          this.stats.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


