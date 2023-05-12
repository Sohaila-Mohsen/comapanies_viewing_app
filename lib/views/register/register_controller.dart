import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RegisterController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController companyAddress = TextEditingController();
  final TextEditingController companyName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  String? lat;
  String? lon;

  emailValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!value.contains('@') || !value.contains('.')) {
      return 'Please enter valid email ex : "example@mail.com"';
    }
    return null;
  }

  companyNameValidator(value) {
    if (value!.length < 1 || value == null) {
      return 'Company Name is required';
    }
    return null;
  }

  companyAddressValidator(value) {
    if (value!.length < 1 || value == null) {
      return 'Company Address is required';
    }
    return null;
  }

  contactPersonNameValidator(value) {
    if (value!.length < 1 || value == null) {
      return 'Contact Person Name is required';
    }
    return null;
  }

  contactPersonNumberValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Contact Person Phone Number is required';
    } else if (value.length != 11) {
      return 'Please enter valid phone ex : "01*********"';
    } else if (value[0] != "0" || value[1] != '1') {
      return 'Please enter valid phone ex : "01*********"';
    }
    return null;
  }

  passwordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password should be at least 8 characters';
    }
    return null;
  }

  confirmPasswordValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value != password.text) {
      return 'Doesn\'t match password';
    }
    return null;
  }

  Future<bool> _handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }


}
