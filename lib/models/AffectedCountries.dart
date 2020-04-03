class AffectedCountries {
  List<String> countries;
  String date;

  AffectedCountries({this.countries, this.date});

  AffectedCountries.fromJson(Map<String, dynamic> json) {
    countries = json['affected_countries'].cast<String>();
    date = json['statistic_taken_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['affected_countries'] = this.countries;
    data['statistic_taken_at'] = this.date;
    return data;
  }
}