class CompanyServiceResponse {
  List<Data>? data;

  CompanyServiceResponse({this.data});

  CompanyServiceResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? companyId;
  String? locationId;
  String? name;
  String? email;
  String? password;
  String? contactName;
  String? contactPhone;
  String? address;
  String? size;
  String? image;
  String? lat;
  String? lon;
  List<Industries>? industries;
  List<Services>? services;

  Data(
      {this.companyId,
      this.locationId,
      this.name,
      this.email,
      this.password,
      this.contactName,
      this.contactPhone,
      this.address,
      this.size,
      this.image,
      this.lat,
      this.lon,
      this.industries,
      this.services});

  Data.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    locationId = json['locationId'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    contactName = json['contactName'];
    contactPhone = json['contactPhone'];
    address = json['address'];
    size = json['size'];
    image = json['image'];
    lat = json['lat'];
    lon = json['lon'];
    if (json['industries'] != null) {
      industries = <Industries>[];
      json['industries'].forEach((v) {
        industries!.add(new Industries.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    data['locationId'] = this.locationId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['contactName'] = this.contactName;
    data['contactPhone'] = this.contactPhone;
    data['address'] = this.address;
    data['size'] = this.size;
    data['image'] = this.image;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    if (this.industries != null) {
      data['industries'] = this.industries!.map((v) => v.toJson()).toList();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Industries {
  String? industryId;
  String? name;

  Industries({this.industryId, this.name});

  Industries.fromJson(Map<String, dynamic> json) {
    industryId = json['industryId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['industryId'] = this.industryId;
    data['name'] = this.name;
    return data;
  }
}

class Services {
  String? serviceId;
  String? serviceName;

  Services({this.serviceId, this.serviceName});

  Services.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    serviceName = json['serviceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceId'] = this.serviceId;
    data['serviceName'] = this.serviceName;
    return data;
  }
}
