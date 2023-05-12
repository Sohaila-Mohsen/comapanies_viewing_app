import 'dart:io';

class CompanyResponse {
  Company? data;

  CompanyResponse({this.data});

  CompanyResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Company.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Company {
  String? companyId;
  String? locationId;
  String? name;
  String? email;
  String? password;
  String? contactName;
  String? contactPhone;
  String? address;
  String? size;
  File? image;
  String? lat;
  String? lon;
  List<String>? industries;

  Company({
    this.companyId,
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
  });

  Company.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    locationId = json['locationId'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    contactName = json['contactName'];
    contactPhone = json['contactPhone'];
    address = json['address'];
    size = json['size'];
    image = (json['image'] != null) ? File(json['image']) : null;
    lat = json['lat'];
    lon = json['lon'];
    if (json['industries'] != null) {
      industries = <String>[];
      json['industries'].forEach((v) {
        industries!.add(new Industries.fromJson(v).industryName!);
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
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    if (this.industries != null) {
      data['industries'] = this.industries!.map((v) => v).toList();
    }
    return data;
  }
}

class IndustriesResponse {
  List<String>? data;

  IndustriesResponse({this.data});

  IndustriesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <String>[];
      json['data'].forEach((v) {
        data!.add(Industries.fromJson(v).industryName!);
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Industries {
  String? industryId;
  String? industryName;

  Industries({this.industryId, this.industryName});

  Industries.fromJson(Map<String, dynamic> json) {
    industryId = json['industryId'];
    industryName = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['industryId'] = this.industryId;
    data['industryName'] = this.industryName;
    return data;
  }
}
