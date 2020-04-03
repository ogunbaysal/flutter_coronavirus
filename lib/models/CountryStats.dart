import 'StatsByCountry.dart';

class CountryStats {
  String country;
  List<StatsByCountry> stats;

  CountryStats({this.country, this.stats});

  CountryStats.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    if (json['latest_stat_by_country'] != null) {
      stats = new List<StatsByCountry>();
      json['latest_stat_by_country'].forEach((v) {
        stats.add(new StatsByCountry.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    if (this.stats != null) {
      data['latest_stat_by_country'] =
          this.stats.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
