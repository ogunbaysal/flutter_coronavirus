class WorldStats {
  String totalCases;
  String totalDeaths;
  String totalRecovered;
  String newCases;
  String newDeaths;
  String statisticTakenAt;

  WorldStats(
      {this.totalCases,
      this.totalDeaths,
      this.totalRecovered,
      this.newCases,
      this.newDeaths,
      this.statisticTakenAt});

  WorldStats.fromJson(Map<String, dynamic> json) {
    totalCases = json['total_cases'];
    totalDeaths = json['total_deaths'];
    totalRecovered = json['total_recovered'];
    newCases = json['new_cases'];
    newDeaths = json['new_deaths'];
    statisticTakenAt = json['statistic_taken_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_cases'] = this.totalCases;
    data['total_deaths'] = this.totalDeaths;
    data['total_recovered'] = this.totalRecovered;
    data['new_cases'] = this.newCases;
    data['new_deaths'] = this.newDeaths;
    data['statistic_taken_at'] = this.statisticTakenAt;
    return data;
  }
}