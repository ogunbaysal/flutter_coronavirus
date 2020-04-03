class CasesByCountry {
  List<CountriesStat> stats;
  String statisticTakenAt;

  CasesByCountry({this.stats, this.statisticTakenAt});

  CasesByCountry.fromJson(Map<String, dynamic> json) {
    if (json['countries_stat'] != null) {
      stats = new List<CountriesStat>();
      json['countries_stat'].forEach((v) {
        stats.add(new CountriesStat.fromJson(v));
      });
    }
    statisticTakenAt = json['statistic_taken_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stats != null) {
      data['countries_stat'] =
          this.stats.map((v) => v.toJson()).toList();
    }
    data['statistic_taken_at'] = this.statisticTakenAt;
    return data;
  }
}

class CountriesStat {
  String countryName;
  String cases;
  String deaths;
  String region;
  String totalRecovered;
  String newDeaths;
  String newCases;
  String seriousCritical;
  String activeCases;
  String totalCasesPer1mPopulation;

  CountriesStat(
      {this.countryName,
      this.cases,
      this.deaths,
      this.region,
      this.totalRecovered,
      this.newDeaths,
      this.newCases,
      this.seriousCritical,
      this.activeCases,
      this.totalCasesPer1mPopulation});

  CountriesStat.fromJson(Map<String, dynamic> json) {
    countryName = json['country_name'];
    cases = json['cases'];
    deaths = json['deaths'];
    region = json['region'];
    totalRecovered = json['total_recovered'];
    newDeaths = json['new_deaths'];
    newCases = json['new_cases'];
    seriousCritical = json['serious_critical'];
    activeCases = json['active_cases'];
    totalCasesPer1mPopulation = json['total_cases_per_1m_population'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_name'] = this.countryName;
    data['cases'] = this.cases;
    data['deaths'] = this.deaths;
    data['region'] = this.region;
    data['total_recovered'] = this.totalRecovered;
    data['new_deaths'] = this.newDeaths;
    data['new_cases'] = this.newCases;
    data['serious_critical'] = this.seriousCritical;
    data['active_cases'] = this.activeCases;
    data['total_cases_per_1m_population'] = this.totalCasesPer1mPopulation;
    return data;
  }
}