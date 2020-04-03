class CountryHistoryByDate {
	int results;
	List<Response> response;

	CountryHistoryByDate({this.results, this.response});

	CountryHistoryByDate.fromJson(Map<String, dynamic> json) {
		results = json['results'];
		if (json['response'] != null) {
			response = new List<Response>();
			json['response'].forEach((v) { response.add(new Response.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['results'] = this.results;
		if (this.response != null) {
      data['response'] = this.response.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Parameters {
	String country;

	Parameters({this.country});

	Parameters.fromJson(Map<String, dynamic> json) {
		country = json['country'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['country'] = this.country;
		return data;
	}
}

class Response {
	String country;
	Cases cases;
	Deaths deaths;
	String day;
	String time;

	Response({this.country, this.cases, this.deaths, this.day, this.time});

	Response.fromJson(Map<String, dynamic> json) {
		country = json['country'];
		cases = json['cases'] != null ? new Cases.fromJson(json['cases']) : null;
		deaths = json['deaths'] != null ? new Deaths.fromJson(json['deaths']) : null;
		day = json['day'];
		time = json['time'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['country'] = this.country;
		if (this.cases != null) {
      data['cases'] = this.cases.toJson();
    }
		if (this.deaths != null) {
      data['deaths'] = this.deaths.toJson();
    }
		data['day'] = this.day;
		data['time'] = this.time;
		return data;
	}
}

class Cases {
	String newCases;
	int active;
	int critical;
	int recovered;
	int total;

	Cases({this.newCases, this.active, this.critical, this.recovered, this.total});

	Cases.fromJson(Map<String, dynamic> json) {
		newCases = json['new'] ?? "0";
		active = json['active'] ?? "0";
		critical = json['critical'] ?? "0";
		recovered = json['recovered']?? "0";
		total = json['total'] ?? "0";
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['new'] = this.newCases ?? "0";
		data['active'] = this.active ?? "0";
		data['critical'] = this.critical ?? "0";
		data['recovered'] = this.recovered ?? "0";
		data['total'] = this.total ?? "0";
		return data;
	}
}

class Deaths {
	String newCases;
	int total;

	Deaths({this.newCases, this.total});

	Deaths.fromJson(Map<String, dynamic> json) {
		newCases = json['new'] ?? "0";
		total = json['total'] ?? "0";
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['new'] = this.newCases ?? "0";
		data['total'] = this.total ?? "0";
		return data;
	}
}