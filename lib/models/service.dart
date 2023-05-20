class ServicesResponse {
  List<Service>? services;

  ServicesResponse({this.services});

  ServicesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      services = <Service>[];
      json['data'].forEach((v) {
        services!.add(new Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['data'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Service {
  String? serviceId;
  String? name;

  Service({this.serviceId, this.name});

  Service.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceId'] = this.serviceId;
    data['name'] = this.name;
    return data;
  }
}
