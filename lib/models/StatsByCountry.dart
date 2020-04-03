class StatsByCountry {
  String id;
  String countryName;
  String totalCases;
  String newCases;
  String activeCases;
  String totalDeaths;
  String newDeaths;
  String totalRecovered;
  String seriousCritical;
  Null region;
  String totalCasesPer1m;
  String recordDate;

  StatsByCountry(
      {this.id,
      this.countryName,
      this.totalCases,
      this.newCases,
      this.activeCases,
      this.totalDeaths,
      this.newDeaths,
      this.totalRecovered,
      this.seriousCritical,
      this.region,
      this.totalCasesPer1m,
      this.recordDate});
      

  StatsByCountry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryName = json['country_name'];
    totalCases = json['total_cases'];
    newCases = json['new_cases'];
    activeCases = json['active_cases'];
    totalDeaths = json['total_deaths'];
    newDeaths = json['new_deaths'];
    totalRecovered = json['total_recovered'];
    seriousCritical = json['serious_critical'];
    region = json['region'];
    totalCasesPer1m = json['total_cases_per1m'];
    recordDate = json['record_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_name'] = this.countryName;
    data['total_cases'] = this.totalCases;
    data['new_cases'] = this.newCases;
    data['active_cases'] = this.activeCases;
    data['total_deaths'] = this.totalDeaths;
    data['new_deaths'] = this.newDeaths;
    data['total_recovered'] = this.totalRecovered;
    data['serious_critical'] = this.seriousCritical;
    data['region'] = this.region;
    data['total_cases_per1m'] = this.totalCasesPer1m;
    data['record_date'] = this.recordDate;
    return data;
  }
}